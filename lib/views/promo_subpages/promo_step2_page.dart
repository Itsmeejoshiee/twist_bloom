import 'package:flutter/material.dart';
import 'package:twist_bloom/views/products_details/Fillers/baby_breath_details.dart';
import 'package:twist_bloom/views/products_details/Fillers/eucalyptus_details.dart';
import 'package:twist_bloom/views/products_details/Fillers/leather_fern_details.dart';
import 'package:twist_bloom/views/products_details/Fillers/wax_flower_details.dart';
import '../../widgets/product_ontap.dart';
import '../products_details/Fillers/lavender_details.dart';
import 'promo_step3_page.dart';
import 'promo_cart.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

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
      'productId':2003,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/eucalyptus.png',
      'title': 'Eucalyptus',
      'price': 30.0,
      'productId':2002,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/leather_fern.png',
      'title': 'Leather Fern',
      'price': 45.0,
      'productId':2004,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/baby_breath.png',
      'title': "Baby's Breath",
      'price': 35.0,
      'productId':2001,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/waxflower.png',
      'title': 'Wax Flower',
      'price': 35.0,
      'productId':2005,
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
        backgroundColor: Color(0xFFFDFAFA),
        elevation: 0,
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
      body: GradientBackground(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/promo_background.png',
                    height: 120.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16.0),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: 'Step 2: Pick your fillers '),
                        TextSpan(
                          text: '(Optional)',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
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
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCardOnTap(
                          imageUrl: filteredProducts[index]['imageUrl'],
                          title: filteredProducts[index]['title'],
                          price: filteredProducts[index]['price'],
                          productId: filteredProducts[index]['productId'],
                          onTap: () {
                            switch (filteredProducts[index]['title']) {
                              case 'Lavender':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LavenderDetails()),
                                );
                                break;
                              case 'Eucalyptus':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const EucalyptusDetails()),
                                );
                                break;
                              case 'Leather Fern':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LeatherFernDetails()),
                                );
                                break;
                              case "Baby's Breath":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const BabyBreathDetails()),
                                );
                                break;
                              case 'Wax Flower':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const WaxFlowerDetails()),
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
                  //PAAYOS NALANG NETO ETO YUNG CONTAINER NA PARANG LINE SA TAASN NG CHECK BASKET BUTTON
                  const Opacity(
                    opacity: 0.0,  // Makes it invisible
                    child: SizedBox(height: 70.0),
                  )
                ],
              ),
            ),
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
                    backgroundColor: const Color(0xFFFF92B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
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
            MaterialPageRoute(builder: (context) => PromoStep3Page()),
          );
        },
        child: const Icon(Icons.arrow_forward, color: Colors.white),
        backgroundColor: const Color(0xFFFF92B2),
      ),
    );
  }

}
