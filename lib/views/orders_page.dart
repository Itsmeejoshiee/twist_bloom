import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';  // Ensure gradient background exists
import 'orders_subpages/shopping_cart.dart';
import 'orders_subpages/like_page.dart';
import 'orders_subpages/to_pay.dart';
import 'orders_subpages/to_rate.dart';
import 'orders_subpages/to_receive.dart';
import 'orders_subpages/to_ship.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: GradientBackground(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMyActivitiesSection(context),
                      _buildSeparator(),
                      _buildMyPurchasesSection(context),
                      _buildSeparator(),
                      _buildMyPreOrdersSection(),
                    ],
                  ),
                ),
              ),
              // Optionally, add a bottom navigation bar here if needed
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
    return Padding(
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
                    MaterialPageRoute(builder: (context) => const LikesPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyPurchasesSection(BuildContext context) {
    final List<Map<String, String>> products = [
      {'image': 'assets/icon/pay.png', 'label': 'To Pay', 'page': 'ToPayPage'},
      {'image': 'assets/icon/ship.png', 'label': 'To Ship', 'page': 'ToShipPage'},
      {'image': 'assets/icon/receive.png', 'label': 'To Receive', 'page': 'ToReceivePage'},
      {'image': 'assets/icon/rate.png', 'label': 'To Rate', 'page': 'ToRatePage'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
            children: products.map((product) {
              return _buildNavigationButton(
                product['image']!,
                product['label']!,
                _getPageFromString(product['page']!),
                context,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 165.0),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to purchase history
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    child: const Text('View Purchase History >'),
                  ),
                ),
              ),
            ],
          ),
        ],
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

  Widget _buildNavigationButton(String imagePath, String label, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        children: [
          Image.asset(imagePath, height: 48),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildMyPreOrdersSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
    );
  }

  Widget _buildPreOrderProduct() {
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
                      'assets/icon/product/product1.jpg',
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
              width: 80,
              height: 21,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                  WidgetStateProperty.all<Color>(const Color(0xFFFF92B2)),
                  elevation: WidgetStateProperty.all<double>(0),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPageFromString(String pageName) {
    switch (pageName) {
      case 'ToPayPage':
        return const ToPayPage(paidProducts: []);
      case 'ToShipPage':
        return const ToShipPage(paidProducts: []);
      case 'ToReceivePage':
        return const ToReceivePage(shippedProducts: []);
      case 'ToRatePage':
        return const ToRatePage(completedProducts: []);
      default:
        return const ToPayPage(paidProducts: []); // Fallback
    }
  }
}
