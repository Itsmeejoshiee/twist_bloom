import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/product.dart';
import 'promo_cart.dart';

class PromoStep6Page extends StatefulWidget {
  const PromoStep6Page({super.key});

  @override
  _PromoStep6Page createState() => _PromoStep6Page();
}

class _PromoStep6Page extends State<PromoStep6Page> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design1.png',
      'title': 'Style #1',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design2.png',
      'title': 'Style #2',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design3.png',
      'title': 'Style #3',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design4.png',
      'title': 'Style #4',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design5.png',
      'title': 'Style #5',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design6.png',
      'title': 'Style #6',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/sample_design7.png',
      'title': 'Style #7',
      'price': 0.0,
    },
  ];

  Map<String, dynamic>? selectedProduct;

  void selectProduct(Map<String, dynamic> product) {
    setState(() {
      if (selectedProduct == product) {
        selectedProduct = null; // Deselect the product if it's already selected
      } else {
        selectedProduct = product; // Select the new product
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIX & MATCH'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              'Step 6: Pick your wrapping style',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.16 / 4,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isSelected = selectedProduct == product;
                  return GestureDetector(
                    onTap: () => selectProduct(product),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink[100] : Colors.white, // Highlight with pink
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.pink : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: ProductCard(
                        imageUrl: product['imageUrl'],
                        title: product['title'],
                        price: product['price'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              backgroundColor: const Color(0xFFFF92B2),
              onPressed: selectedProduct != null
                  ? () {
                // Add to Basket functionality goes here
              }
                  : null, // Disable button if no product is selected
              label: const Text(
                "Check Basket",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              backgroundColor: const Color(0xFFFF92B2), // Pink background
              onPressed: selectedProduct != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PromoCartPage(selectedProduct: selectedProduct!), // Pass selectedProduct
                  ),
                );
              }
                  : null, // Disable button if no product is selected
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
