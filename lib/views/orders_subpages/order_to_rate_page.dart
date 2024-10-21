import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Add this package for the rating bar
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'package:twist_bloom/views/orders_subpages/order_completed_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_receive_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_ship_page.dart';
import 'package:twist_bloom/views/orders_subpages/order_to_pay_page.dart';

class ToRatePage extends StatefulWidget {
  const ToRatePage({super.key});

  @override
  _ToRatePageState createState() => _ToRatePageState();
}

class _ToRatePageState extends State<ToRatePage> {
  List<String> itemsToRate = [
    'Poppies and Rose Bouquet'
  ]; // List of items to rate

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
            const SizedBox(height: 16),
            ...itemsToRate.map((item) => _buildProductCard(
                  context,
                  productName: item,
                  price: '₱150',
                  deliveredDate: 'Delivered on: September 20, 2024',
                  buttonText: 'Rate',
                  buttonColor: const Color(0xFFE63D7C),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavigationButton('To Pay', const ToPayPage(), context,
            isCurrentPage: false),
        _buildNavigationButton('To Ship', const ToShipPage(), context,
            isCurrentPage: false),
        _buildNavigationButton('To Receive', const ToReceivePage(), context,
            isCurrentPage: false),
        _buildNavigationButton('Completed', const CompletedPage(), context,
            isCurrentPage: false),
        _buildNavigationButton('To Rate', const ToRatePage(), context,
            isCurrentPage: true),
      ],
    );
  }

  Widget _buildNavigationButton(String label, Widget page, BuildContext context,
      {required bool isCurrentPage}) {
    return GestureDetector(
      onTap: isCurrentPage
          ? null
          : () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => page,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
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
              color: isCurrentPage ? const Color(0xFFE63D7C) : Colors.black,
            ),
          ),
          if (isCurrentPage)
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

  Widget _buildProductCard(
    BuildContext context, {
    required String productName,
    required String price,
    required String deliveredDate,
    required String buttonText,
    required Color buttonColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFF92B2).withOpacity(0.35),
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
                  'assets/icon/product/bouquets/sample_design6.png',
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
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
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
                    onPressed: () {
                      _showRatingDialog(context, productName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
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

  void _showRatingDialog(BuildContext context, String productName) {
    double userRating = 3; // Default rating value
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rate Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("How would you rate this product?"),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  userRating = rating;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without rating
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _submitRating(productName, userRating);
                Navigator.pop(context); // Close the dialog after rating
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _submitRating(String productName, double rating) {
    // Remove the item from the list after rating
    setState(() {
      itemsToRate.remove(productName);
    });

    // Navigate back to the orders page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const CompletedPage(), // Navigate to the orders page
      ),
    );
  }
}
