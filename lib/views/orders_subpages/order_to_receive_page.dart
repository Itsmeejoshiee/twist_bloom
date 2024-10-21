import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'order_to_pay_page.dart';
import 'order_to_ship_page.dart';
import 'order_completed_page.dart';
import 'order_to_rate_page.dart';
import 'package:firebase_database/firebase_database.dart';
import '/../user_session.dart';

class ToReceivePage extends StatefulWidget {
  const ToReceivePage({super.key});

  @override
  _ToReceivePageState createState() => _ToReceivePageState();
}

class _ToReceivePageState extends State<ToReceivePage> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final userId = UserSession().getUserId(); // Get the user ID
    final database = FirebaseDatabase.instance.ref();

    // Path to the "To Ship" folder
    final toreceivePath = '/users/$userId/toreceive';

    // Get the products from Firebase
    final snapshot = await database.child(toreceivePath).get();

    if (snapshot.exists) {
      // Clear existing products
      products.clear();

      // Convert snapshot to a list of maps
      for (var product in snapshot.children) {
        // Safely cast to Map<String, dynamic>
        final productData = product.value as Map<Object?, Object?>?;
        if (productData != null) {
          products.add(Map<String, dynamic>.from(productData));
        }
      }

      // Update the UI
      setState(() {});
    } else {
      print("No products found in the cart.");
    }
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
        body: Column(
          children: [
            _buildNavigationRow(context),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildPreOrderProduct(context, products[index]);
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
        _buildNavigationButton('To Pay', const ToPayPage(), context, isCurrentPage: false),
        _buildNavigationButton('To Ship', const ToShipPage(), context, isCurrentPage: false),
        _buildNavigationButton('To Receive', const ToReceivePage(), context, isCurrentPage: true),
        _buildNavigationButton('Completed', const CompletedPage(), context, isCurrentPage: false),
        _buildNavigationButton('To Rate', const ToRatePage(), context, isCurrentPage: false),
      ],
    );
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
              color: isCurrentPage ? const Color(0xFFE63D7C) : Colors.black, // Set color based on current page
            ),
          ),
          if (isCurrentPage) // Underline for the current page
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 60,
              color: const Color(0xFFE63D7C),
            ),
        ],
      ),
    );
  }

  Widget _buildPreOrderProduct(BuildContext context, Map<String, dynamic> product) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFAD0D4),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
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
                  product['image'] ?? 'assets/icon/product/bouquets/sample_design6.png', // Default image if none provided
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
                    product['name'] ?? 'Product Name',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['price'] ?? '₱0',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'On ${product['orderDate'] ?? 'Date'}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Expected Delivery: ${product['expectedDelivery'] ?? 'Date'}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      _moveToCompleted(context, product); // Pass the product to mark as received
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE63D7C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Order Received',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {}, // Add action if needed
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 12, color: Color(0xFFE63D7C)),
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

  Future<void> _moveToCompleted(BuildContext context, Map<String, dynamic> product) async {
    final userId = UserSession().getUserId(); // Get the user ID

    // Reference to Firebase Database
    final database = FirebaseDatabase.instance.ref();

    // The path for the preorder and completed orders
    final preorderPath = '/users/$userId/toreceive';
    final completedPath = '/users/$userId/tocompleted';

    // Move data from preorder to completed
    await database.child(completedPath).push().set(product);
    await database.child(preorderPath).remove(); // Optionally remove the original data

    // Optionally, navigate to the completed page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const CompletedPage()),
          (route) => false,
    );
  }
}
