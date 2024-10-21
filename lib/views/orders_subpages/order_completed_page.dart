import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_receive_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_ship_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_rate_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_pay_page.dart';
import 'package:twist_bloom/user_session.dart'; // Import UserSession to access userId

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final List<Map<String, dynamic>> products = []; // To hold fetched products

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products when the widget is initialized
  }

  Future<void> _fetchProducts() async {
    final userId = UserSession().getUserId(); // Get the user ID
    final database = FirebaseDatabase.instance.ref();

    // Path to the "To Completed" folder
    final completedPath = '/users/$userId/tocompleted';

    // Get the products from Firebase
    final snapshot = await database.child(completedPath).get();

    if (snapshot.exists) {
      // Clear existing products
      products.clear();

      // Convert snapshot to a list of maps
      for (var product in snapshot.children) {
        final productData = product.value as Map<Object?, Object?>?;
        if (productData != null) {
          products.add(Map<String, dynamic>.from(productData));
        }
      }
      // Update the UI
      setState(() {});
    } else {
      print("No products found in the completed folder.");
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
            const SizedBox(height: 16), // Add spacing between tabs and products
            // Display fetched product cards
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(
                    context,
                    productName: product['name'] ?? 'Unknown Product',
                    price: '₱${product['price']?.toString() ?? '0'}',
                    deliveredDate: 'Delivered on: ${product['deliveredDate'] ?? 'Unknown Date'}',
                    buttonText1: 'Rate',
                    buttonText2: 'Buy again', // Added "Buy again" button
                    buttonColor1: Color(0xFFE63D7C), // Pink button for "Rate"
                    buttonColor2: Color(0xFFFFFFFF), // White background for "Buy again"
                    textColor2: Color(0xFFE63D7C), // Pink text for "Buy again"
                  );
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
        _buildNavigationButton('To Receive', const ToReceivePage(), context, isCurrentPage: false),
        _buildNavigationButton('Completed', const CompletedPage(), context, isCurrentPage: true),
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

  Widget _buildProductCard(
      BuildContext context, {
        required String productName,
        required String price,
        required String deliveredDate,
        required String buttonText1,
        String? buttonText2, // Optional second button
        required Color buttonColor1,
        Color? buttonColor2,
        Color? textColor1 = Colors.white, // Default to white text
        Color? textColor2, // Optional text color for second button
      }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFF92B2).withOpacity(0.35), // Matching the pink color from the image
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
                  'assets/icon/product/bouquets/sample_design6.png', // Replace with correct asset for each product
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
                    productName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deliveredDate,
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
                    onPressed: () {}, // Action for the first button
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor1, // Dynamic button color for first button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Remove the side property to avoid outline
                    ),
                    child: Text(
                      buttonText1,
                      style: TextStyle(fontSize: 12, color: textColor1), // Dynamic text color
                    ),
                  ),
                ),
                if (buttonText2 != null) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {}, // Action for the second button
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor2 ?? Colors.white, // Default to white if not provided
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // Remove the side property to avoid outline
                      ),
                      child: Text(
                        buttonText2,
                        style: TextStyle(fontSize: 12, color: textColor2 ?? Color(0xFFE63D7C)), // Pink text for second button
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
