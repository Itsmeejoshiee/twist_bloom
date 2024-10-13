import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/product.dart';
import 'promo_step4_page.dart';
import 'promo_cart.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class PromoStep3Page extends StatefulWidget {
  const PromoStep3Page({super.key});

  @override
  _PromoStep3Page createState() => _PromoStep3Page();
}

class _PromoStep3Page extends State<PromoStep3Page> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/wrappers/kraft_board.png',
      'title': 'Kraft Board',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/kraft_paper.png',
      'title': 'Kraft Paper',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/navy_blue.png',
      'title': 'Navy Blue',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/lime_green.png',
      'title': 'Lime Green',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/cardamom_purple.png',
      'title': 'Cardamom Purple',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/milky_yellow.png',
      'title': 'Milky Yellow',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/gouache.png',
      'title': 'Gouache + Milky White',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/wrappers/wine_red.png',
      'title': 'Wine Red',
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
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xFFFDFAFA), // Make app bar transparent
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GradientBackground(
        child: Padding(
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
                'Step 3: Pick your Main Wrapper',
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row
          children: [
            Expanded(
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFFFF92B2),
                onPressed: () {
                  // Navigate to PromoCartPage regardless of product selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PromoCartPage(selectedProduct: selectedProduct ?? {}),
                    ),
                  );
                },
                label: const Text(
                  "Check Basket",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16), // Add some space between buttons
            FloatingActionButton(
              backgroundColor: const Color(0xFFFF92B2), // Pink background
              onPressed: selectedProduct != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PromoStep4Page(selectedProduct: selectedProduct!), // Pass selectedProduct
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
