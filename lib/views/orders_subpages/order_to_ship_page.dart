import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../widgets/gradient_background.dart';
import 'order_to_pay_page.dart';
import 'order_to_receive_page.dart';
import 'order_completed_page.dart';
import 'order_to_rate_page.dart';

class ToShipPage extends StatefulWidget {
  const ToShipPage({super.key});

  @override
  _ToShipPageState createState() => _ToShipPageState();
}

class _ToShipPageState extends State<ToShipPage> {
  final DatabaseReference _toShipRef = FirebaseDatabase.instance.ref().child('users/user1/toship');
  List<Map<dynamic, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchToShipProducts();
  }

  void _fetchToShipProducts() {
    _toShipRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _products = data.entries.map((entry) => entry.value as Map<dynamic, dynamic>).toList();
        });
      }
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
        body: Column(
          children: [
            _buildNavigationRow(context),
            const SizedBox(height: 16), // Add some spacing between tabs and product
            Expanded(
              child: _products.isNotEmpty
                  ? ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return _buildProductCard(context, product);
                },
              )
                  : const Center(child: CircularProgressIndicator()),
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
        _buildNavigationButton('To Ship', const ToShipPage(), context, isCurrentPage: true),
        _buildNavigationButton('To Receive', const ToReceivePage(), context, isCurrentPage: false),
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

  Widget _buildProductCard(BuildContext context, Map<dynamic, dynamic> product) {
    final imageUrl = product['image'] ?? '';  // Get image URL from product details

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                child: imageUrl.startsWith('assets/')
                    ? Image.asset(
                  imageUrl, // Use asset image for local images
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  imageUrl, // Use network image for online images
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(), // Handle error loading image
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? 'Unknown Product',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₱${product['price'] ?? '0'}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'On ${product['date'] ?? 'Unknown Date'}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['status'] ?? 'Unknown Status',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 13), // Add space between text and buttons
            Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {}, // No action needed since it's already paid
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCE3E5), // Change to gray to indicate "Paid"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Paid',
                      style: TextStyle(fontSize: 12, color: Colors.green), // Change text color to green
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


  Widget _buildPlaceholderImage() {
    return Image.asset(
      'assets/icon/product/default_image.png', // Path to your local placeholder image
      fit: BoxFit.cover,
    );
  }
}
