import 'package:flutter/material.dart';
import 'promo_step2_page.dart';
import 'package:twist_bloom/widgets/product.dart';

class PromoStep1Page extends StatefulWidget {
  const PromoStep1Page({super.key});

  @override
  _PromoStep1Page createState() => _PromoStep1Page();
}

class _PromoStep1Page extends State<PromoStep1Page> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
      'title': 'Tulip',
      'price': 65.0,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Sunflower',
      'price': 75.0,
    },
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
      'title': 'Poppy (2 Stems)',
      'price': 45.0,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Rose',
      'price': 70.0,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Lily',
      'price': 65.0,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
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
    return Scaffold(
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
      body: Padding(
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
              'Step 1: Pick your flower (1 Flower)',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PromoStep2Page()),
          );
        },
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Color(0xFFFF92B2),
      ),
    );
  }
}

// ProductCard widget to reflect design changes
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₱ $price'),
                Row(
                  children: const [
                    Icon(Icons.favorite_border, size: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
