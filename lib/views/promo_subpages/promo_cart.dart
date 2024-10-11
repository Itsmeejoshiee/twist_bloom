import 'package:flutter/material.dart';

class PromoCartPage extends StatefulWidget {
  const PromoCartPage({Key? key, required Map<String, dynamic> selectedProduct}) : super(key: key);

  @override
  _PromoCartPage createState() => _PromoCartPage();
}

class _PromoCartPage extends State<PromoCartPage> {
  bool _isEditing = false; // Flag to check if in editing mode
  List<bool> _selectedProducts = List.generate(10, (index) => false); // Dummy product selection state
  List<Map<String, dynamic>> _products = [
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Product 1', 'price': 10.0, 'variations': ['Size S', 'Size M', 'Size L']},
    {'image': 'assets/icon/product/product2.jpg', 'title': 'Product 2', 'price': 15.0, 'variations': ['Color Red', 'Color Blue']},
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Product 3', 'price': 20.0, 'variations': ['Size M', 'Size L', 'Size XL']},
    // Add more products as needed
  ];
  List<int> _quantities = List.generate(10, (index) => 1); // Dummy quantity state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing; // Toggle editing mode
              });
            },
            child: Text(
              _isEditing ? 'Done' : 'Edit',
              style: const TextStyle(color: Color(0xFFFF92B2)),
            ),
          ),
        ],
        elevation: 4, // Shadow for the AppBar
      ),
      body: Column(
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
                    const Divider(thickness: 1, color: Colors.grey), // Spacer line
                  ],
                );
              },
            ),
          ),
          if (_isEditing) _buildEditingNavBar(),
          if (!_isEditing) _buildCheckoutNavBar(),
        ],
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
                  // Select all products
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
                  // Delete selected products
                  _products.removeWhere((product) => _selectedProducts[_products.indexOf(product)]);
                  _selectedProducts = List.generate(_products.length, (index) => false);
                  _quantities = List.generate(_products.length, (index) => 1); // Reset quantities
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
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Checkout logic
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
