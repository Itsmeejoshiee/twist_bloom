import 'package:flutter/material.dart';
import 'package:twist_bloom/views/orders_subpages/to_pay.dart';
import 'package:twist_bloom/views/orders_subpages/to_rate.dart';
import 'package:twist_bloom/views/orders_subpages/to_receive.dart';
import 'package:twist_bloom/views/orders_subpages/to_ship.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class CompletedPage extends StatelessWidget {
  final List<Map<String, dynamic>> completedProducts;

  const CompletedPage({super.key, required this.completedProducts});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Completed'),
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
                  _buildNavigationButton('To Rate', ToRatePage(completedProducts: completedProducts), context),
                ],
              ),

              Expanded(
                child: completedProducts.isNotEmpty
                    ? ListView.builder(
                        itemCount: completedProducts.length,
                        itemBuilder: (context, index) {
                          return _ProductCard(
                            image: completedProducts[index]['image'],
                            title: completedProducts[index]['title'],
                            price: completedProducts[index]['price'],
                            status: 'Completed',
                          );
                        },
                      )
                    : const Center(child: Text('No completed orders.')),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildNavigationButton(String label, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));
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
  final String status;

  const _ProductCard({
    required this.image,
    required this.title,
    required this.price,
    required this.status,
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
          Text(status, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
