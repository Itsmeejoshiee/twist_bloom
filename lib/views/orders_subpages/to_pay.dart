import 'package:flutter/material.dart';
import 'package:twist_bloom/views/orders_subpages/completed.dart';
import 'package:twist_bloom/views/orders_subpages/to_ship.dart';
<<<<<<< Updated upstream
import 'package:twist_bloom/widgets/gradient_background.dart';
=======
import 'package:twist_bloom/views/orders_subpages/to_receive.dart';
import 'package:twist_bloom/views/orders_subpages/to_rate.dart';
>>>>>>> Stashed changes

class ToPayPage extends StatefulWidget {
  final List<Map<String, dynamic>> paidProducts;
  final Function(Map<String, dynamic>) onPaid;

  const ToPayPage({super.key, required this.paidProducts, required this.onPaid});

  @override
  _ToPayPageState createState() => _ToPayPageState();
}

class _ToPayPageState extends State<ToPayPage> {
  late List<Map<String, dynamic>> _toPayProducts;

  @override
  void initState() {
    super.initState();
    _toPayProducts = widget.paidProducts;
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('To Pay'),
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
                  : Center(child: Text('No products to pay for.')),
            ),
          ],
          ),
        ),
      );
    }
=======
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Pay'),
      ),
      body: Column(
        children: [
          _buildNavigationBar(context),
          Expanded(
            child: _toPayProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: _toPayProducts.length,
                    itemBuilder: (context, index) {
                      return _ProductCard(
                        product: _toPayProducts[index],
                        onActionPressed: () {
                          widget.onPaid(_toPayProducts[index]);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ToShipPage(
                              paidProducts: [_toPayProducts[index]],
                              onShipped: (product) {},
                            ),
                          ));
                        },
                        actionLabel: 'Pay',
                      );
                    },
                  )
                : const Center(child: Text('No products to pay for.')),
          ),
        ],
      ),
    );
  }
>>>>>>> Stashed changes

  Widget _buildNavigationBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavigationButton('To Pay', () => Navigator.of(context).popUntil((route) => route.isFirst)),
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
