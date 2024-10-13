import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class PromoCartPage extends StatefulWidget {
  const PromoCartPage({super.key, required Map<String, dynamic> selectedProduct});

  @override
  _PromoCartPageState createState() => _PromoCartPageState();
}

class _PromoCartPageState extends State<PromoCartPage> {
  final bool _isEditing = false;
  List<bool> _selectedProducts = List.generate(10, (index) => false); // Dummy product selection state
  final List<Map<String, dynamic>> _products = [
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Poppy', 'description': 'Red', 'price': 45.00, 'category': 'Flower'},
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Lavender', 'description': 'Green', 'price': 45.00, 'category': 'Fillers'},
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Navy Blue', 'description': '', 'price': 25.00, 'category': 'Wrapper'},
    // Add more products as needed
  ];
  final List<int> _quantities = List.generate(10, (index) => 1); // Dummy quantity state

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFFDFAFA), // Make app bar transparent
            title: const Text('Basket'),
            elevation: 0,
          ),
          body: GradientBackground(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      _buildCategory('Flower'),
                      _buildProductList('Flower'),
                      const SizedBox(height: 10),
                      _buildCategory('Fillers'),
                      _buildProductList('Fillers'),
                      const SizedBox(height: 10),
                      _buildCategory('Wrapper'),
                      _buildProductList('Wrapper'),
                    ],
                  ),
                ),
                _buildCheckoutNavBar(),
              ],
            ),
          ),
      ),
    );
  }

  // Builds a category heading (e.g. Flower, Fillers, Wrapper)
  Widget _buildCategory(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        category,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Builds a list of products under each category
  Widget _buildProductList(String category) {
    final productsInCategory = _products.where((product) => product['category'] == category).toList();

    return Column(
      children: productsInCategory.map((product) {
        final index = _products.indexOf(product);
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: _selectedProducts[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedProducts[index] = value ?? false;
                    });
                  },
                ),
                Image.asset(
                  product['image'],
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (product['description'] != '')
                        Text(
                          product['description'],
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      Text(
                        '₱${product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_quantities[index] > 1) {
                            _quantities[index]--;
                          }
                        });
                      },
                    ),
                    Text('${_quantities[index]}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _quantities[index]++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Builds the checkout bar at the bottom
  Widget _buildCheckoutNavBar() {
    final totalPrice = _products.asMap().entries.fold(0.0, (sum, entry) {
      final index = entry.key;
      final product = entry.value;
      return sum + (product['price'] * _quantities[index]);
    });

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: _selectedProducts.every((selected) => selected),
                onChanged: (bool? value) {
                  setState(() {
                    _selectedProducts = List.generate(_selectedProducts.length, (index) => value ?? false);
                  });
                },
              ),
              const Text('ALL'),
            ],
          ),
          Text('Total: ₱${totalPrice.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              // Checkout logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF92B2),
            ),
            child: const Text('Checkout',
            style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
