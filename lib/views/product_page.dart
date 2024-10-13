import 'package:flutter/material.dart';
import 'package:twist_bloom/views/products_details/lavender_details.dart';
import 'package:twist_bloom/widgets/product_ontap.dart';
import '../widgets/gradient_background.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/flowers/tulip.png',
      'title': 'Tulip',
      'price': 65.0,
    },
    {
      'imageUrl': 'assets/icon/product/flowers/sunflower.png',
      'title': 'Sunflower',
      'price': 75.0,
    },
    {
      'imageUrl': 'assets/icon/product/flowers/poppy.png',
      'title': 'Poppy (2 Stems)',
      'price': 45.0,
    },
    {
      'imageUrl': 'assets/icon/product/flowers/rose.png',
      'title': 'Rose',
      'price': 70.0,
    },
    {
      'imageUrl': 'assets/icon/product/flowers/lily.png',
      'title': 'Lily',
      'price': 65.0,
    },
    {
      'imageUrl': 'assets/icon/product/flowers/gerbera.png',
      'title': 'Gerbera',
      'price': 70.0,
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
                    return ProductCardOnTap(
                      imageUrl: filteredProducts[index]['imageUrl'],
                      title: filteredProducts[index]['title'],
                      price: filteredProducts[index]['price'],
                      onTap: () {
                        // Add navigation based on the title of the product
                        switch (filteredProducts[index]['title']) {
                          case 'Tulip':
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LavenderDetails()),
                            );
                            break;
                          case 'Sunflower':
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LavenderDetails()), // Replace with actual details page
                            );
                            break;
                        // Add more cases for other products as needed
                          default:
                          // Handle default case or show an error message
                            break;
                        }
                      },
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
