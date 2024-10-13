import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/product.dart';
import 'promo_step5_page.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class PromoStep4Page extends StatefulWidget {
  final Map<String, dynamic> selectedProduct;
  const PromoStep4Page({super.key, required this.selectedProduct});

  @override
  _PromoStep4Page createState() => _PromoStep4Page();
}

class _PromoStep4Page extends State<PromoStep4Page> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/accents/sinamay_cream.png',
      'title': 'Sinamay (Cream)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/accents/sinamay_golden_yellow.png',
      'title': 'Sinamay (Golden Yellow)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/accents/tissue_paper.png',
      'title': 'Tissue Paper (White)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/accents/snowflake_net.png',
      'title': 'Snowflake Net (White)',
      'price': 0.0,
    },
    {
      'imageUrl': 'assets/icon/product/accents/pearl_wave_yarn.png',
      'title': 'Pearl Wave Yarn (Per meter)',
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
    return GradientBackground(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('MIX & MATCH'),
            surfaceTintColor: Colors.transparent,
            backgroundColor: Color(0xFFFEFAEB), // Make app bar transparent
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.4, 1),
              end: Alignment(0.4, -1),
              colors: [
                Color.fromRGBO(224, 209, 158, 0.14),
                Color.fromRGBO(255, 252, 237, 1.0),
              ],
            ),
          ),
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
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    children: <TextSpan>[
                      const TextSpan(text: 'Step 4: Pick your Accent '),
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
                      MaterialPageRoute(builder: (context) => PromoStep5Page(selectedProduct: {},))
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
      ),
    );
  }
}
