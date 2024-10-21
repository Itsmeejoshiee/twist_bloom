import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twist_bloom/views/orders_subpages/order_completed_page.dart';
import 'orders_subpages/order_to_pay_page.dart';
import 'orders_subpages/order_to_rate_page.dart';
import 'orders_subpages/order_to_receive_page.dart';
import 'orders_subpages/order_to_ship_page.dart';
import 'orders_subpages/shopping_cart.dart';
import 'orders_subpages/like_page.dart';
import '../widgets/gradient_background.dart';
import '../user_session.dart'; // Import the user session for accessing userId

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userId = UserSession().getUserId(); // Get userId directly from UserSession

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMyActivitiesSection(context),
                _buildSeparator(),
                _buildMyPurchasesSection(context),
                _buildSeparator(),
                _buildMyPreOrdersSection(context, userId!), // Pass userId to this method
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: 1.5,
      color: Colors.grey[400],
      width: double.infinity,
    );
  }

  Widget _buildMyActivitiesSection(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY ACTIVITIES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCustomIconButton(
                  'assets/icon/cart.png',
                  'My Shopping Cart',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                ),
                _buildCustomIconButton(
                  'assets/icon/likes.png',
                  'My Likes',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LikesPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPurchasesSection(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY PURCHASES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToPayPage()),
                    );
                  },
                  child: _buildCustomVerticalIconButton('assets/icon/pay.png', 'To Pay'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToShipPage()),
                    );
                  },
                  child: _buildCustomVerticalIconButton('assets/icon/ship.png', 'To Ship'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToReceivePage()),
                    );
                  },
                  child: _buildCustomVerticalIconButton('assets/icon/receive.png', 'To Receive'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToRatePage()),
                    );
                  },
                  child: _buildCustomVerticalIconButton('assets/icon/rate.png', 'To Rate'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 165.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CompletedPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('View Purchase History  >'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPreOrdersSection(BuildContext context, String userId) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY PRE-ORDERS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPreOrderProduct(context, userId), // Pass userId to this method
          ],
        ),
      ),
    );
  }

  Widget _buildCustomIconButton(String imagePath, String label, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: _buildResizedImage(imagePath, 24, 24),
      label: Text(label, style: const TextStyle(color: Color(0xFF000000))),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFFF92B2), width: 1),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget _buildCustomVerticalIconButton(String imagePath, String label) {
    return Column(
      children: [
        _buildResizedImage(imagePath, 48, 48),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildResizedImage(String imagePath, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Image.asset(imagePath),
      ),
    );
  }

  Widget _buildPreOrderProduct(BuildContext context, String userId) {
    return FutureBuilder<List<Product>>(
      future: _fetchPreOrders(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching pre-orders'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No pre-orders available'));
        }

        // Display the pre-order products
        final products = snapshot.data!;
        return Column(
          children: products.map((product) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: const Color(0xFFFF92B2).withOpacity(0.35),
              elevation: 0,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: product.image != null && product.image!.startsWith('assets/')
                                  ? AssetImage(product.image!) // Load as an asset
                                  : NetworkImage(product.image!), // Fallback if not asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text('Price: \$${product.price}', style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                        // Add Confirm Button
                        IconButton(
                          icon: const Icon(Icons.shopping_cart, color: Colors.grey),
                          onPressed: () {
                            _moveToCart(context, userId, product); // Call the function to move to cart
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
  void _moveToCart(BuildContext context, String userId, Product product) {
    final DatabaseReference _database = FirebaseDatabase.instance.ref();

    // Create a new cart item with product details
    final cartItem = {
      'name': product.name,
      'price': product.price,
      'image': product.image,
      'quantity': product.quantity,
      'color': product.color,
      'date': product.date,
    };

    // Push the cart item to the user's cart in Firebase
    _database.child('users/$userId/cart').push().set(cartItem).then((_) {
      // Remove the product from pre-orders after successfully adding to cart
      _removePreOrder(userId, product).then((_) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} added to cart!')),
        );
      }).catchError((error) {
        // Handle error when removing pre-order
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove from pre-orders: $error')),
        );
      });
    }).catchError((error) {
      // Handle error adding to cart
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $error')),
      );
    });
  }

  Future<void> _removePreOrder(String userId, Product product) async {
    final DatabaseReference _database = FirebaseDatabase.instance.ref();

    // Fetch pre-orders to find the specific product to remove
    final snapshot = await _database.child('users/$userId/preorder').get();

    if (snapshot.exists) {
      for (var child in snapshot.children) {
        final productData = child.value as Map<dynamic, dynamic>;

        // Compare with product name and other details to find the matching product
        if (productData['name'] == product.name &&
            productData['price'] == product.price) {
          // Remove the specific product from pre-orders
          await _database.child('users/$userId/preorder/${child.key}').remove();
          break; // Exit after removing the first matching product
        }
      }
    }
  }




  Future<List<Product>> _fetchPreOrders(String userId) async {
    final databaseReference = FirebaseDatabase.instance.ref();
    try {
      final snapshot = await databaseReference.child('users/$userId/preorder').get();

      if (snapshot.exists) {
        print('Snapshot exists for userId: $userId'); // Debugging line
        if (snapshot.children.isNotEmpty) {
          List<Product> products = [];
          for (var child in snapshot.children) {
            print('Child key: ${child.key}, value: ${child.value}'); // Debugging line
            final productData = child.value as Map<dynamic, dynamic>;
            products.add(Product.fromJson(productData));
          }
          return products;
        } else {
          print('No pre-orders found for userId: $userId'); // Debugging line
          return [];
        }
      } else {
        print('No data exists for userId: $userId'); // Debugging line
        return [];
      }
    } catch (e) {
      print('Error fetching pre-orders: $e'); // Debugging line
      return []; // Return an empty list in case of error
    }
  }

}

// Product model for handling product data
class Product {
  final String? date;
  final String? image;
  final String? name; // Added name property
  final int quantity;
  final String? color;
  final double price;

  Product({
    this.date,
    this.image,
    this.name, // Include in the constructor
    required this.quantity,
    this.color,
    required this.price,
  });

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      date: json['date'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String? ?? '', // Default to empty string if null
      quantity: (json['quantity'] is int ? json['quantity'] as int : 0),
      color: json['color'] as String? ?? '', // Default to empty string if null
      price: (json['price'] is num ? json['price'].toDouble() : 0.0),
    );
  }

}
