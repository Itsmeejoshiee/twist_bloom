import 'package:flutter/material.dart';
import 'package:twist_bloom/views/promo_subpages/promo_cart.dart';
import 'promo_step2_page.dart';
import 'package:twist_bloom/widgets/product.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class PromoStep1Page extends StatefulWidget {
  const PromoStep1Page({super.key});

  @override
  _PromoStep1Page createState() => _PromoStep1Page();
}

class _PromoStep1Page extends State<PromoStep1Page> {
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
          appBar: AppBar(
            title: const Text('MIX & MATCH'),
            backgroundColor: Colors.transparent, // Make app bar transparent
            elevation: 0, // Remove shadow
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Image.asset('assets/icon/filter.png'),
                onPressed: () {
                  filterProducts();
                },
              ),
            ],
          ),
          body: Container(
            child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner image at the top
                    Image.asset(
                      'assets/promo_background.png',
                      height: 120.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Step 1: Pick your flower',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3.16 / 4, // Aspect ratio similar to image
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
              ),
              // Positioned button at the bottom center
              Positioned(
                bottom: 16,
                left: 0,
                right: 76,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PromoCartPage(selectedProduct: {})),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 16.0),
                      backgroundColor: const Color(0xFFFF92B2), // Customize your color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min, // Ensures the Row takes up minimal space
                      children: [
                        Icon(
                          Icons.shopping_cart, // Basket icon
                          color: Colors.white,    // Icon color
                        ),
                        SizedBox(width: 8),        // Space between icon and text
                        Text(
                          'Check Basket',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PromoStep2Page()),
              );
            },
            child: const Icon(Icons.arrow_forward, color: Colors.white),
            backgroundColor: const Color(0xFFFF92B2),
          ),
      ),
    );
  }
}
