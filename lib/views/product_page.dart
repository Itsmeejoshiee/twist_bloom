import 'package:flutter/material.dart';
import 'package:twist_bloom/views/products_details/Fillers/lavender_details.dart';
import 'package:twist_bloom/widgets/product_ontap.dart';
import '../widgets/gradient_background.dart';
import '../views/products_details/product_details.dart';
import 'account_page.dart';

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
      'title': "Baby's Breath",
      'price': 35.0,
    },
    {
      'imageUrl': 'assets/icon/product/fillers/waxflower.png',
      'title': 'Wax Flower',
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
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white10,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 32,
                ),
                onPressed: () {
                  // Navigate to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountPage()),
                  );
                },
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Add search logic here
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Filter button inside the body
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Products',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset('assets/icon/filter.png',height: 50, width: 50,),
                      onPressed: () {
                        filterProducts();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 13,
                    childAspectRatio: 3.16 / 4,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCardOnTap(
                      imageUrl: filteredProducts[index]['imageUrl'],
                      title: filteredProducts[index]['title'],
                      price: filteredProducts[index]['price'],
                      onTap: () {
                        // Add navigation logic based on the product's title
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
        ),
      ),
    );
  }
}
