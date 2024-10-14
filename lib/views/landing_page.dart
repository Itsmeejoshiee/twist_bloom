import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'dart:async';
import '../widgets/product_ontap.dart';
import 'promo_page.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_widget.dart';
import 'principal_classes.dart';
import 'package:twist_bloom/views/products_details/Bouquets/lily_pretty_details.dart';

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
          // Show the profile icon and SearchWidget only for HomePage and OrdersPage
          if (_currentIndex == 0) ...[
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.account_circle_outlined,
                    color: Colors.black, size: 48),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountPage()),
                  );
                },
              ),
            ),
            const Positioned(
              top: 50,
              right: 10,
              child: SearchWidget(),
            ),
          ],
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
    return GradientBackground(
      child: ListView(
        padding: const EdgeInsets.only(top: 120),
        children: const [
          ElevatedPromoWidget(),
          LatestProductsSlideshow(),
          FeaturedProductsGrid(),
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
          MaterialPageRoute(builder: (context) => const PromoScreen()),
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
                child: const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    Icon(
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
      'imageUrl': 'assets/icon/product/bouquets/latest1.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest2.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest3.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest4.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest5.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest6.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest7.png',
    },
    {
      'imageUrl': 'assets/icon/product/bouquets/latest8.png',
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
          const SizedBox(height: 10),
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        'imageUrl': 'assets/icon/product/bouquets/FeaturedProduct1.png',
        'title': 'Lily Pretty',
        'price': 19.99,
      },
      {
        'imageUrl': 'assets/icon/product/bouquets/FeaturedProduct2.png',
        'title': 'Tulip Elegante',
        'price': 29.99,
      },
      {
        'imageUrl': 'assets/icon/product/bouquets/FeaturedProduct3.png',
        'title': 'Lavender Lover',
        'price': 39.99,
      },
      {
        'imageUrl': 'assets/icon/product/bouquets/FeaturedProduct4.png',
        'title': 'Sunshine Wonder',
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
              final product = products[index];

              return ProductCardOnTap(
                imageUrl: product['imageUrl'],
                title: product['title'],
                price: product['price'],
                onTap: () {
                  // Define different navigation based on index or product property
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LilyPrettyDetails(), // Navigate to page 1
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LilyPrettyDetails(), // Navigate to page 2
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LilyPrettyDetails(), // Navigate to page 2
                      ),
                    );
                  }  else if (product['title'] == 'Product 3') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LilyPrettyDetails(), // Navigate to page 3
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
