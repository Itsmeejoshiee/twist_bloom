import 'package:flutter/material.dart';
import 'package:twist_bloom/views/orders_subpages/order_completed_page.dart';
import 'orders_subpages/order_to_pay_page.dart';
import 'orders_subpages/order_to_rate_page.dart';
import 'orders_subpages/order_to_receive_page.dart';
import 'orders_subpages/order_to_ship_page.dart';
import 'orders_subpages/shopping_cart.dart';
import 'orders_subpages/like_page.dart';
import '../widgets/gradient_background.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                _buildMyActivitiesSection(context), // Pass context here
                _buildSeparator(),
                _buildMyPurchasesSection(context),  // Pass context here
                _buildSeparator(),
                _buildMyPreOrdersSection(context),  // Pass context here
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
                      MaterialPageRoute(
                          builder: (context) => const LikesPage()),
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

  Widget _buildMyPurchasesSection(BuildContext context) { // Add BuildContext here
    const double buttonTextSize = 16.0;

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

  Widget _buildMyPreOrdersSection(BuildContext context) { // Add BuildContext here
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
            _buildPreOrderProduct(context), // Pass context here
          ],
        ),
      ),
    );
  }

  Widget _buildCustomIconButton(
      String imagePath,
      String label,
      VoidCallback onPressed, // Accept a callback function
      ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: _buildResizedImage(imagePath, 24, 24),
      label: Text(label, style: TextStyle(color: const Color(0xFF000000))),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: const Color(0xFFFF92B2), width: 1),
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

  Widget _buildPreOrderProduct(BuildContext context) { // Add BuildContext here
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
                      Text('P150',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('On September 21, 2024',
                          style: TextStyle(fontSize: 10)),
                      SizedBox(height: 4),
                      Text('For Delivery',
                          style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: SizedBox(
              width: 100,
              height: 21,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, // Use context here
                    MaterialPageRoute(builder: (context) => ToPayPage()),
                  );
                },
                child: const Text('Confirm', style: TextStyle(fontSize: 12, color: Color(0xFFB42323)),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
