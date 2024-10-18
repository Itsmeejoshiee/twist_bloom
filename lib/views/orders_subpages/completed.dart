import 'package:flutter/material.dart';
import 'package:twist_bloom/views/orders_subpages/to_pay.dart';
import 'package:twist_bloom/views/orders_subpages/to_ship.dart';
<<<<<<< Updated upstream
import 'package:twist_bloom/widgets/gradient_background.dart';
=======
import 'package:twist_bloom/views/orders_subpages/to_receive.dart';
import 'package:twist_bloom/views/orders_subpages/to_rate.dart';
>>>>>>> Stashed changes

class CompletedPage extends StatelessWidget {
  final List<Map<String, dynamic>> completedProducts;
  final Function(Map<String, dynamic>) onRate;

  const CompletedPage({super.key, required this.completedProducts, required this.onRate});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
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
=======
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed'),
      ),
      body: Column(
        children: [
          _buildNavigationBar(context),
          Expanded(
            child: completedProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: completedProducts.length,
                    itemBuilder: (context, index) {
                      return _ProductCard(
                        product: completedProducts[index],
                        onActionPressed: () {
                          onRate(completedProducts[index]);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ToRatePage(
                              ratedProducts: [completedProducts[index]],
                              onRated: (product) {},
                              completedProducts: [],
                            ),
                          ));
                        },
                        actionLabel: 'Rate',
                      );
                    },
                  )
                : const Center(child: Text('No completed products.')),
          ),
        ],
      ),
    );
>>>>>>> Stashed changes
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavigationButton('To Pay', () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ToPayPage(paidProducts: [], onPaid: (product) {}),
          ));
        }),
        _buildNavigationButton('To Ship', () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ToShipPage(paidProducts: [], onShipped: (product) {}),
          ));
        }),
        _buildNavigationButton('To Receive', () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ToReceivePage(shippedProducts: [], onOrderReceived: (product) {}),
          ));
        }),
        _buildNavigationButton('Completed', () => Navigator.of(context).popUntil((route) => route.isFirst)),
        _buildNavigationButton('To Rate', () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ToRatePage(ratedProducts: [], onRated: (product) {}, completedProducts: []),
          ));
        }),
      ],
    );
  }

  Widget _buildNavigationButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
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
  final Map<String, dynamic> product;
  final VoidCallback onActionPressed;
  final String actionLabel;

  const _ProductCard({
    required this.product,
    required this.onActionPressed,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(product['image'], fit: BoxFit.contain),
          ),
          Text(product['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('\$${product['price']}'),
          ElevatedButton(
            onPressed: onActionPressed,
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}
