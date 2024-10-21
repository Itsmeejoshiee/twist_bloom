// Import necessary packages
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'package:twist_bloom/views/orders_subpages/order_completed_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_receive_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_ship_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_rate_page.dart';
import '/../user_session.dart';

// Product class to hold the product details
class Product {
  final String key; // Add the key attribute
  final String name;
  final String price;
  final String date;
  final String image;
  final String color;
  final int quantity;

  Product({
    required this.key, // Add this parameter
    required this.name,
    required this.price,
    required this.date,
    required this.image,
    required this.color,
    required this.quantity,
  });

  factory Product.fromMap(Map<dynamic, dynamic> map, String key) {
    return Product(
      key: key, // Set the key here
      name: map['name'] ?? '',
      price: map['price']?.toString() ?? '',
      date: map['date'] ?? '',
      image: map['image'] ?? '',
      color: map['color'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'date': date,
      'image': image,
      'color': color,
      'quantity': quantity,
    };
  }
}


class ToPayPage extends StatefulWidget {
  const ToPayPage({super.key});

  @override
  _ToPayPageState createState() => _ToPayPageState();
}

class _ToPayPageState extends State<ToPayPage> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  List<Product> _products = [];
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    String? userId = UserSession().getUserId(); // Replace with the actual user ID
    final snapshot = await _databaseRef.child('users/$userId/checkout').get();

    if (snapshot.exists) {
      final productList = snapshot.value as Map<dynamic, dynamic>;
      List<Product> products = [];
      productList.forEach((key, value) {
        products.add(Product.fromMap(value, key)); // Pass the key to the Product constructor
      });
      setState(() {
        _products = products;
      });
    } else {
      print('No data available.');
    }

    setState(() {
      _isLoading = false; // Reset loading state
    });
  }

  Future<void> _moveToShip(Product product) async {
    setState(() {
      _isLoading = true; // Set loading state while processing
    });

    String? userId = UserSession().getUserId(); // Replace with the actual user ID

    // Create a map with the product data and add the 'status' field
    Map<String, dynamic> productWithStatus = product.toMap();
    productWithStatus['status'] = 'Not Paid'; // Add the status field

    // Move product to "To Ship" location with the status
    await _databaseRef.child('users/$userId/toship').push().set(productWithStatus);

    // Remove the product from the "To Pay" section using its unique key
    await _databaseRef.child('users/$userId/checkout/${product.key}').remove();

    // Refresh the product list after moving the product
    await _fetchProducts(); // Fetch the updated product list

    setState(() {
      _isLoading = false; // Reset loading state
    });
  }



  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('My Purchases'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : _products.isEmpty
            ? Center(child: Text('No products available.')) // Empty state
            : Column(
          children: [
            _buildNavigationRow(context),
            const SizedBox(height: 16), // Space before the product card
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(context, _products[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavigationButton('To Pay', const ToPayPage(), context, isCurrentPage: true),
        _buildNavigationButton('To Ship', const ToShipPage(), context, isCurrentPage: false),
        _buildNavigationButton('To Receive', const ToReceivePage(), context, isCurrentPage: false),
        _buildNavigationButton('Completed', const CompletedPage(), context, isCurrentPage: false),
        _buildNavigationButton('To Rate', const ToRatePage(), context, isCurrentPage: false),
      ],
    );
  }
  Future<void> _removeProduct(Product product) async {
    setState(() {
      _isLoading = true; // Set loading state while processing
    });

    String? userId = UserSession().getUserId(); // Replace with the actual user ID

    // Remove the product from the "To Pay" section using its unique key
    await _databaseRef.child('users/$userId/checkout/${product.key}').remove();

    // Refresh the product list after removing the product
    await _fetchProducts(); // Fetch the updated product list

    setState(() {
      _isLoading = false; // Reset loading state
    });
  }


  Widget _buildNavigationButton(String label, Widget page, BuildContext context, {required bool isCurrentPage}) {
    return GestureDetector(
      onTap: isCurrentPage
          ? null
          : () {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child; // No animation
            },
          ),
              (Route<dynamic> route) => route.isFirst,
        );
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isCurrentPage ? Color(0xFFE63D7C) : Colors.black, // Set color based on current page
            ),
          ),
          if (isCurrentPage) // Underline for the current page
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 60,
              color: Color(0xFFE63D7C),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFAD0D4),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.image, // Using Image.asset for local image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'P${product.price}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date: ${product.date}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Quantity: ${product.quantity}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Color: ${product.color}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16), // Add space between text and buttons
            Column(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the move to ship function with the product
                      _moveToShip(product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE63D7C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the remove product function with the product
                      _removeProduct(product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      'Remove',
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
}

