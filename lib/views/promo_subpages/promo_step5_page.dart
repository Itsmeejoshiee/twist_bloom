import 'package:flutter/material.dart';
import 'package:twist_bloom/views/promo_subpages/promo_cart.dart';
import 'package:twist_bloom/widgets/product.dart';
import 'promo_step6_page.dart';

class PromoStep5Page extends StatefulWidget {
  final Map<String, dynamic> selectedProduct;
  const PromoStep5Page({super.key, required this.selectedProduct});

  @override
  _PromoStep5Page createState() => _PromoStep5Page();
}

class _PromoStep5Page extends State<PromoStep5Page> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/ribbons/cream.png',
      'title': 'Cream',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/milky_white.png',
      'title': 'Milky White',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/golden_yellow.png',
      'title': 'Golden Yellow',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/wine_red_ribbon.png',
      'title': 'Wine Red',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/pink_rose.png',
      'title': 'Pink Rose',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/light_blue.png',
      'title': 'Light Blue',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/blue_fishtail.png',
      'title': 'Blue (fishtail)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/burgundy_fishtail.png',
      'title': 'Burgundy (fishtail)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/light_purple_fishtail.png',
      'title': 'Light Purple (fishtail)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/white_fishtail.png',
      'title': 'White (fishtail)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/ribbons/milky_white_fishtail.png',
      'title': 'Milky White (fishtail)',
      'price': 0.0,
    },
  ];

  List<Map<String, dynamic>> selectedProducts = [];  // Allow multiple selections

  void selectProduct(Map<String, dynamic> product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product); // Deselect the product if it's already selected
      } else if (selectedProducts.length < 2) {
        selectedProducts.add(product);  // Select the new product if less than 2
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
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(text: 'Step 5: Pick your ribbon '),
                  TextSpan(
                    text: '(Up to 2)',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ],
              ),
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
                  final isSelected = selectedProducts.contains(product);
                  return GestureDetector(
                    onTap: () => selectProduct(product),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink[100] : Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
          children: [
            Expanded(
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFFFF92B2),
                onPressed: selectedProducts.isEmpty
                    ? () {
                  // Basket Location
                }
                    : null, // Disable button if no product is selected
                label: const Text("Check Basket",
                  style: TextStyle(color: Colors.white),),
                icon: const Icon(Icons.shopping_cart,
                  color: Colors.white,),
              ),
            ),
            const SizedBox(width: 16), // Space between buttons
            FloatingActionButton(
              backgroundColor: const Color(0xFFFF92B2), // Pink background
              onPressed: selectedProducts.isNotEmpty
                  ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PromoStep6Page(selectedProduct: {},))
                );
              }
                  : null, // Disable button if no product is selected
              child: const Icon(
                Icons.arrow_forward, // Icon with >
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
