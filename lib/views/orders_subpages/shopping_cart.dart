import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '/../user_session.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEditing = false;
  List<bool> _selectedProducts = [];
  List<Map<String, dynamic>> _products = [];
  List<int> _quantities = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    String? userId = UserSession().getUserId();
    DatabaseReference cartRef = FirebaseDatabase.instance.ref('/users/$userId/cart');

    // Fetch data once
    DatabaseEvent event = await cartRef.once();
    DataSnapshot snapshot = event.snapshot; // Get the DataSnapshot

    final data = snapshot.value as Map<dynamic, dynamic>?;

    // Log the data retrieved from Firebase
    print('Data received from Firebase: $data');

    if (data != null) {
      _products.clear();
      _quantities.clear();
      _selectedProducts.clear();

      // Iterate over the products in the cart
      data.forEach((key, value) {
        // Check if the value is a Map and has the expected keys
        if (value is Map<dynamic, dynamic>) {
          String productName = value['name'] as String? ?? 'Unnamed Product'; // Default value
          String productImage = value['image'] as String? ?? 'default_image_url'; // Default image
          double productPrice = (value['price'] as num?)?.toDouble() ?? 0.0; // Default price
          String productColor = value['color'] as String? ?? 'Unknown Color'; // Default color
          String productDate = value['date'] as String? ?? 'Unknown Date'; // Default date
          int productQuantity = (value['quantity'] as num?)?.toInt() ?? 0; // Default quantity

          // Log individual product details to identify issues
          print('Product details - Name: $productName, Image: $productImage, Price: $productPrice, Color: $productColor, Date: $productDate, Quantity: $productQuantity');

          // Check for null values before adding to the lists
          if (productName.isNotEmpty) {
            _products.add({
              'name': productName,
              'price': productPrice,
              'image': productImage,
              'color': productColor,
              'date': productDate,
              'key': key, // Store the key to reference later
            });
            _quantities.add(productQuantity); // Use the quantity from the product details
            _selectedProducts.add(false); // Default selection to false
          } else {
            print('Product name is null or empty for key: $key');
          }
        } else {
          print('Invalid data format for product: $value');
        }
      });

      // Log the populated product list
      print('Products populated: $_products');

      // Refresh the UI
      setState(() {});
    } else {
      print('No products found in the cart.');
    }
  }

  Future<void> _moveToCheckout() async {
    String? userId = UserSession().getUserId();
    DatabaseReference checkoutRef = FirebaseDatabase.instance.ref('/users/$userId/checkout');

    // Iterate through all products and add them to checkout
    for (int i = 0; i < _products.length; i++) {
      try {
        // Log the product being added to checkout
        print('Adding product to checkout: ${_products[i]['name']}');

        // Use push() to create a unique key for each product
        String uniqueKey = checkoutRef.push().key ?? 'product_$i';

        // Create a new entry in the checkout folder with a unique key
        await checkoutRef.child(uniqueKey).set({
          'name': _products[i]['name'],
          'price': _products[i]['price'],
          'image': _products[i]['image'],
          'color': _products[i]['color'],
          'date': _products[i]['date'],
          'quantity': _quantities[i],
        });
        print('Product added to checkout successfully with key: $uniqueKey');
      } catch (error) {
        print('Failed to add product to checkout: $error');
      }
    }

    // Remove all products from the cart after checkout
    _removeAllProductsFromCart();

    // Refresh the UI or provide feedback to the user
    setState(() {
      // Refresh the cart items after checkout
      _loadCartItems();
    });
  }


// Method to remove all products from the cart
  Future<void> _removeAllProductsFromCart() async {
    String? userId = UserSession().getUserId();
    DatabaseReference cartRef = FirebaseDatabase.instance.ref('/users/$userId/cart');

    try {
      // Clear the entire cart
      await cartRef.remove();
      print('All products removed from the cart successfully.');
    } catch (error) {
      print('Failed to remove products from cart: $error');
    }
  }



  Future<void> _removeSelectedProducts() async {
    String? userId = UserSession().getUserId();
    DatabaseReference cartRef = FirebaseDatabase.instance.ref('/users/$userId/cart');

    // Collect the keys of the products to delete
    List<String> keysToDelete = [];

    for (int i = _products.length - 1; i >= 0; i--) {
      if (_selectedProducts[i]) {
        // Get the key associated with the product
        String productKey = _products[i]['key'] ?? ''; // Make sure to store the key when loading products
        if (productKey.isNotEmpty) {
          keysToDelete.add(productKey);
        }

        // Remove from the local lists
        _products.removeAt(i);
        _quantities.removeAt(i);
        _selectedProducts.removeAt(i);
      }
    }

    // Remove products from the Firebase database
    for (String key in keysToDelete) {
      await cartRef.child(key).remove();
    }

    // Log deletion
    print('Removed selected products from cart.');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFFDFAFA),
        title: const Text('Shopping Cart'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              _isEditing ? 'Done' : 'Edit',
              style: const TextStyle(color: Color(0xFFFF92B2)),
            ),
          ),
        ],
        elevation: 4,
      ),
      body: GradientBackground(
        child: Stack(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          if (_isEditing)
                            Checkbox(
                              value: _selectedProducts[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  _selectedProducts[index] = value ?? false;
                                });
                              },
                            ),
                          Image.asset(
                            _products[index]['image'],
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _products[index]['name'], // Corrected from 'title' to 'name'
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$${_products[index]['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          if (!_isEditing)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (_quantities[index] > 1) {
                                        _quantities[index]--;
                                      }
                                    });
                                  },
                                ),
                                Text('${_quantities[index]}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      _quantities[index]++;
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                    ],
                  );
                },
              ),
            ),
            if (_isEditing) _buildEditingNavBar(),
            if (!_isEditing) _buildCheckoutNavBar(),
          ],
        ),
      ),
    );
  }

  // Editing Mode Navigation Bar
  Widget _buildEditingNavBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align items to the end
          children: [
            // Spacer to push the button to the right
            const Spacer(),
            TextButton(
              onPressed: () async {
                await _removeSelectedProducts(); // Call the new delete method
                setState(() {
                  // Reset the selected products list
                  _selectedProducts = List.generate(_products.length, (index) => false);
                  _quantities = List.generate(_products.length, (index) => 1);
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Checkout Mode Navigation Bar
  Widget _buildCheckoutNavBar() {
    final totalPrice = _products.asMap().entries.fold(0.0, (sum, entry) {
      final index = entry.key;
      final product = entry.value;
      return sum + (product['price'] * _quantities[index]);
    });

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${totalPrice.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                _moveToCheckout();
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
