import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'promo_page.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_widget.dart';
import '../widgets/product.dart';
import 'principal_classes.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const OrdersPage(),
    const AllProductsPage(),
    const MessagesPage(),
    const SettingsPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (_currentIndex != 4)
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.account_circle,
                    color: Colors.black, size: 48),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountPage()),
                  );
                },
              ),
            ),
          if (_currentIndex != 4) // Conditionally render SearchWidget for other pages
            const Positioned(
              top: 20,
              right: 10,
              child: SearchWidget(),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, 1),
          end: Alignment(0.4, -1),
          colors: [
            Color.fromRGBO(224, 209, 158, 0.14),
            Color.fromRGBO(255, 252, 237, 1.0)
          ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 90),
        children: [
          const ElevatedPromoWidget(),
          LatestProductsSlideshow(),
          const FeaturedProductsGrid(),
        ],
      ),
    );
  }
}

class ElevatedPromoWidget extends StatelessWidget {
  const ElevatedPromoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PromoScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Background image
              Image.asset(
                'assets/promo_background.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Card content
              Container(
                height: 150,
                padding: const EdgeInsets.fromLTRB(16, 1, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.40), // Optional overlay for readability
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Latest Promo!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Click to discover our latest offers',
                            style: TextStyle(
                              color: Colors.white, // Text color
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.local_offer,
                      size: 40,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatestProductsSlideshow extends StatefulWidget {
  const LatestProductsSlideshow({super.key});

  @override
  _LatestProductsSlideshowState createState() =>
      _LatestProductsSlideshowState();
}

class _LatestProductsSlideshowState extends State<LatestProductsSlideshow> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  final Duration _scrollDuration = const Duration(seconds: 3);
  final List<Map<String, dynamic>> slideshowProducts = [
    {
      'imageUrl': 'assets/icon/product/sample_bouquets/lily_pretty.png',
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
    },
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
    },
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
    },
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _autoScroll();
  }

  void _autoScroll() {
    Future.delayed(_scrollDuration, () {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= (slideshowProducts.length / 2).ceil()) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LATEST',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: _pageController,
              itemCount: (slideshowProducts.length / 2).ceil(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, pageIndex) {
                final startIndex = pageIndex * 2;
                final endIndex =
                    (startIndex + 2).clamp(0, slideshowProducts.length);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: endIndex - startIndex,
                    itemBuilder: (context, index) {
                      final product = slideshowProducts[startIndex + index];
                      final isCurrentPage = pageIndex == _currentPage;

                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: isCurrentPage ? 1.0 : 0.5,
                        child: isCurrentPage
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.transparent,
                                ),
                                child: ProductSquareCard(
                                  imageUrl: product['imageUrl'],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    child: ProductSquareCard(
                                      imageUrl: product['imageUrl'],
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedProductsGrid extends StatelessWidget {
  const FeaturedProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'imageUrl': 'assets/icon/product/sample_bouquets/lily_pretty.png',
        'title': 'Lily Pretty',
        'price': 19.99,
      },
      {
        'imageUrl': 'assets/icon/product/product2.jpg',
        'title': 'Product 2',
        'price': 29.99,
      },
      {
        'imageUrl': 'assets/icon/product/product1.jpg',
        'title': 'Product 3',
        'price': 39.99,
      },
      {
        'imageUrl': 'assets/icon/product/product2.jpg',
        'title': 'Product 4',
        'price': 49.99,
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 0.0),
            child: Text(
              'FEATURED PRODUCTS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.16 / 4,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                imageUrl: products[index]['imageUrl'],
                title: products[index]['title'],
                price: products[index]['price'],
              );
            },
          ),
        ],
      ),
    );
  }
}
