import 'package:flutter/material.dart';
import '../widgets/product.dart';
import '../widgets/gradient_background.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
      'title': 'Product 1',
      'price': 69.99,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Product 2',
      'price': 29.99,
    },
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
      'title': 'Product 1',
      'price': 49.99,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Product 2',
      'price': 59.99,
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void filterProducts() {
    setState(() {
      filteredProducts.sort((a, b) => a['price'].compareTo(b['price']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          title: const Text('All Products'),
          actions: [
            IconButton(
              icon: Image.asset('assets/icon/filter.png'),
              onPressed: () {
                filterProducts();
              },
            ),
          ],
        ),
        body: GradientBackground(child:Padding(
          padding: const EdgeInsets.fromLTRB(8, 1, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar is expanded by default
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.16 / 4,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageUrl: filteredProducts[index]['imageUrl'],
                      title: filteredProducts[index]['title'],
                      price: filteredProducts[index]['price'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),),
      ),
    );
  }
}
