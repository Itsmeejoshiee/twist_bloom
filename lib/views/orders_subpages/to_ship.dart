import 'package:flutter/material.dart';
import 'package:twist_bloom/views/orders_subpages/completed.dart';
import 'package:twist_bloom/views/orders_subpages/to_pay.dart';
import 'package:twist_bloom/views/orders_subpages/to_rate.dart';
import 'package:twist_bloom/views/orders_subpages/to_receive.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class ToShipPage extends StatelessWidget {
  final List<Map<String, dynamic>> paidProducts;

  const ToShipPage({super.key, required this.paidProducts});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('To Ship'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavigationButton('To Pay', const ToPayPage(paidProducts: []), context),
                _buildNavigationButton('To Ship', const ToShipPage(paidProducts: []), context),
                _buildNavigationButton('To Receive', const ToReceivePage(shippedProducts: []), context),
                _buildNavigationButton('Completed', const CompletedPage(completedProducts: []), context),
                _buildNavigationButton('To Rate', const ToRatePage(completedProducts: []), context),
              ],
            ),
            Expanded(
              child: paidProducts.isNotEmpty
                  ? ListView.builder(
                      itemCount: paidProducts.length,
                      itemBuilder: (context, index) {
                        return _ProductCard(
                          image: paidProducts[index]['image'],
                          title: paidProducts[index]['title'],
                          price: paidProducts[index]['price'],
                        );
                      },
                    )
                  : const Center(child: Text('No products to ship.')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String label, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => route.isFirst,
        );
      },
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;

  const _ProductCard({
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('\$$price'),
        ],
      ),
    );
  }
}
