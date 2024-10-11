import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/product.dart'; // Importing Product widget
import 'promo_step3_page.dart';

class PromoStep2Page extends StatefulWidget {
  const PromoStep2Page({super.key});

  @override
  _PromoStep2Page createState() => _PromoStep2Page();
}

class _PromoStep2Page extends State<PromoStep2Page> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/fillers/lavender.png',
      'title': 'Lavender',
      'price': 45.0,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/eucalyptus.png',
      'title': 'Eucalyptus',
      'price': 30.0,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/leather_fern.png',
      'title': 'Leather Fern',
      'price': 45.0,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/baby_breath.png',
      'title': "Baby's Breath (2 Stems)",
      'price': 35.0,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/waxflower.png',
      'title': 'Waxflower (2 Stems)',
      'price': 35.0,
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
              'Step 2: Pick your filler',
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
            MaterialPageRoute(builder: (context) => const PromoStep3Page()),
          );
        },
        child: const Icon(Icons.arrow_forward,color: Colors.white,),
        backgroundColor: const Color(0xFFFF92B2),
      ),
    );
  }
}
