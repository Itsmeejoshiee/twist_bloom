import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'order_to_pay_page.dart';
import 'order_to_ship_page.dart';
import 'order_completed_page.dart';
import 'order_to_rate_page.dart';

class ToReceivePage extends StatelessWidget {
  const ToReceivePage({super.key});

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
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                  _buildPreOrderProduct(context), // Add the product widget here
                ],
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

  Widget _buildPreOrderProduct(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFAD0D4),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 60, // Adjust width here (if necessary)
              height: 60, // Adjust height here (if necessary)
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Poppies and Rose Bouquet',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('₱150',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('On September 21, 2024',
                      style: TextStyle(fontSize: 10)),
                  SizedBox(height: 4),
                  Text('Expected Delivery: September 24, 2024',
                      style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompletedPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE63D7C),
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
}
