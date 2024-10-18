import 'package:flutter/material.dart';
import 'package:twist_bloom/views/orders_subpages/completed.dart';
import 'package:twist_bloom/views/orders_subpages/to_pay.dart';
import 'package:twist_bloom/views/orders_subpages/to_ship.dart';
<<<<<<< Updated upstream
import 'package:twist_bloom/widgets/gradient_background.dart';
=======
import 'package:twist_bloom/views/orders_subpages/to_receive.dart';
>>>>>>> Stashed changes

class ToRatePage extends StatelessWidget {
  final List<Map<String, dynamic>> ratedProducts;
  final Function(Map<String, dynamic>) onRated;
  final List<Map<String, dynamic>> completedProducts;

  const ToRatePage({super.key, required this.ratedProducts, required this.onRated, required this.completedProducts});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('To Rate'),
      ),
      body: Column(
        children: [
<<<<<<< Updated upstream
          
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
         
=======
          _buildNavigationBar(context),
>>>>>>> Stashed changes
          Expanded(
            child: ratedProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: ratedProducts.length,
                    itemBuilder: (context, index) {
                      return _ProductCard(
                        product: ratedProducts[index],
                        onActionPressed: () {
                          onRated(ratedProducts[index]);
                          // Here you can implement additional logic if needed
                        },
                        actionLabel: 'Rate',
                      );
                    },
                  )
<<<<<<< Updated upstream
                : const Center(
                child: Text('No products to rate.')),
=======
                : const Center(child: Text('No products to rate.')),
>>>>>>> Stashed changes
          ),
        ],
      ),),
    );
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
        _buildNavigationButton('Completed', () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompletedPage(completedProducts: [], onRate: (product) {}),
          ));
        }),
        _buildNavigationButton('To Rate', () => Navigator.of(context).popUntil((route) => route.isFirst)),
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
