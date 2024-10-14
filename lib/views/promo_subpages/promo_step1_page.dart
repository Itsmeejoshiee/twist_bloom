import 'package:flutter/material.dart';
import 'package:twist_bloom/views/products_details/Flowers/gerbera_details.dart';
import 'package:twist_bloom/views/products_details/Flowers/lily_details.dart';
import 'package:twist_bloom/views/products_details/Flowers/poppy_details.dart';
import 'package:twist_bloom/views/products_details/Flowers/rose_details.dart';
import 'package:twist_bloom/views/products_details/Flowers/sunflower_details.dart';
import 'package:twist_bloom/views/products_details/Flowers/tulip_details.dart';
import 'package:twist_bloom/views/promo_subpages/promo_cart.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../widgets/product_ontap.dart';
import 'promo_step2_page.dart';

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
      'title': 'Poppy',
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
      'title': 'Gerbera Daisy',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIX & MATCH'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFFDFAFA), // Make app bar transparent
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icon/filter.png'),
            onPressed: filterProducts,
          ),
        ],
      ),
      body: GradientBackground(
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
                                  MaterialPageRoute(builder: (context) => const TulipDetails()),
                                );
                                break;
                              case 'Sunflower':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SunflowerDetails()), // Replace with actual details page
                                );
                                break;
                              case 'Rose':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RoseDetails()), // Replace with actual details page
                                );
                                break;
                              case 'Poppy':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PoppyDetails()), // Replace with actual details page
                                );
                                break;
                              case 'Lily':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LilyDetails()), // Replace with actual details page
                                );
                                break;
                              case 'Gerbera Daisy':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const GerberaDetails()), // Replace with actual details page
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
                  const Opacity(
                    opacity: 0.0,  // Makes it invisible
                    child: SizedBox(height: 70.0),
                  )
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
    );
  }
}
