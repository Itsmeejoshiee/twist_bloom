import 'package:flutter/material.dart';
import 'cart.dart';
import 'like_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.4, 1),
            end: Alignment(0.4, -1),
            colors: [
              Color.fromRGBO(224, 209, 158, 0.14),
              Color.fromRGBO(255, 252, 237, 1.0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMyActivitiesSection(context),
              _buildSeparator(),
              _buildMyPurchasesSection(),
              _buildSeparator(),
              _buildMyPreOrdersSection(),
            ],
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
                  'My Shipping Cart',
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

  Widget _buildMyPurchasesSection() {
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
                _buildCustomVerticalIconButton('assets/icon/pay.png', 'To Pay'),
                _buildCustomVerticalIconButton(
                    'assets/icon/ship.png', 'To Ship'),
                _buildCustomVerticalIconButton(
                    'assets/icon/receive.png', 'To Receive'),
                _buildCustomVerticalIconButton(
                    'assets/icon/rate.png', 'To Rate'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 165.0),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 14),
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

  Widget _buildMyPreOrdersSection() {
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
            _buildPreOrderProduct(),
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

  Widget _buildPreOrderProduct() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFF92B2),
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
                      'assets/icon/product/product1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Poppies and Rose Bouquet',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('P150',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('On September 21, 2024',
                          style: TextStyle(fontSize: 10)),
                      const SizedBox(height: 4),
                      const Text('For Delivery',
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
              width: 80,
              height: 21,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Confirm'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                  WidgetStateProperty.all<Color>(Color(0xFFFF92B2)),
                  elevation: WidgetStateProperty.all<double>(0),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
