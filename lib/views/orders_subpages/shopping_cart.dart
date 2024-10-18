import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEditing = false;
  List<bool> _selectedProducts = List.generate(10, (index) => false);
  final List<Map<String, dynamic>> _products = [
    {'image': 'assets/icon/product/flowers/tulip.png', 'title': 'Tulip', 'price': 65.0, 'variations': ['Red', 'Yellow', 'Purple', 'Fuschia', 'Orange', 'Baby Blue', 'Violet', 'Pink', 'Golden', 'Cobalt', 'Indigo', 'White']},
    {'image': 'assets/icon/product/flowers/sunflower.png', 'title': 'Sunflower', 'price': 75.0, 'variations': ['Red', 'Yellow', 'Purple', 'Fuschia', 'Orange', 'Baby Blue', 'Violet', 'Pink', 'Golden', 'Cobalt', 'Indigo', 'White']},
    {'image': 'assets/icon/product/bouquets/FeaturedProduct2.png', 'title': 'Tulip Elegante', 'price': 260.0, 'variations': ['Not applicable']},
  ];
  List<int> _quantities = List.generate(10, (index) => 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xFFFDFAFA),
          title: const Text('Shopping Cart'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Text(
                _isEditing ? 'Done' : 'Edit',
                style: const TextStyle(color: Color(0xFFFF92B2)),
              ),
            ),
          ],
          elevation: 4,
        ),
        body: GradientBackground(
          child: Stack(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            if (_isEditing)
                              Checkbox(
                                value: _selectedProducts[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _selectedProducts[index] = value ?? false;
                                  });
                                },
                              ),
                            Image.asset(
                              _products[index]['image'],
                              width: 80,
                              height: 80,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _products[index]['title'],
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton<String>(
                                    value: _products[index]['variations'].first,
                                    onChanged: (String? newValue) {
                                      // Handle variation change
                                    },
                                    items: _products[index]['variations']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text(
                                    '\$${_products[index]['price']}',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            if (!_isEditing)
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
                        const Divider(thickness: 1, color: Colors.grey),
                      ],
                    );
                  },
                ),
              ),
              if (_isEditing) _buildEditingNavBar(),
              if (!_isEditing) _buildCheckoutNavBar(),
            ],
          ),
        ),
    );
  }

  // Editing Mode Navigation Bar
  Widget _buildEditingNavBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < _selectedProducts.length; i++) {
                    _selectedProducts[i] = true;
                  }
                });
              },
              child: const Text('Select All'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _products.removeWhere((product) => _selectedProducts[_products.indexOf(product)]);
                  _selectedProducts = List.generate(_products.length, (index) => false);
                  _quantities = List.generate(_products.length, (index) => 1);
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Checkout Mode Navigation Bar
  Widget _buildCheckoutNavBar() {
    final totalPrice = _products.asMap().entries.fold(0.0, (sum, entry) {
      final index = entry.key;
      final product = entry.value;
      return sum + (product['price'] * _quantities[index]);
    });

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
              child: const Text(
                'Checkout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
