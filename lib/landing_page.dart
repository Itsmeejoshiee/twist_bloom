import 'dart:ui';
import 'package:flutter/material.dart';
import 'product.dart';
import 'dart:async';
import 'like_page.dart';
import 'cart.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          const Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black, size: 48),
              onPressed: null,
            ),
          ),
          Positioned(
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

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double iconSize;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2), // Shadow on top
          ),
        ],
        color: Colors.white, // Background color of the bar
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          _buildNavBarItem(
            iconPath: 'assets/icon/home.png',
            index: 0,
            isSelected: currentIndex == 0,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/all_products.png',
            index: 1,
            isSelected: currentIndex == 1,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/orders.png',
            index: 2,
            isSelected: currentIndex == 2,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/messages.png',
            index: 3,
            isSelected: currentIndex == 3,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/settings.png',
            index: 4,
            isSelected: currentIndex == 4,
          ),
        ],
        selectedItemColor: Colors.transparent, // Transparent to allow custom icon styling
        unselectedItemColor: Colors.grey, // Color for unselected items
        showUnselectedLabels: false, // Hide labels
        showSelectedLabels: false, // Hide labels
        backgroundColor: Colors.transparent, // Transparent background for the bar
        elevation: 0, // No elevation for a flat bottom bar
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required String iconPath,
    required int index,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize + 16, // Adjust size with padding
        height: iconSize + 16, // Adjust size with padding
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF92B2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12), // Rounded corners for the square
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected) _buildInnerShadow(), // Add inner shadow only if selected
            Center(
              child: Image.asset(
                iconPath,
                color: isSelected ? Colors.white : Colors.black, // Change icon color based on selection
                width: iconSize,
                height: iconSize,
              ),
            ),
          ],
        ),
      ),
      label: '', // No label to keep it icon-only
    );
  }

  Widget _buildInnerShadow() {
    return CustomPaint(
      size: Size(iconSize + 16, iconSize + 16), // Adjust size to match container
      painter: InnerShadowPainter(),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final Color shadowColor;
  final double blurRadius;
  final double borderRadius;

  InnerShadowPainter({
    this.shadowColor = Colors.black,
    this.blurRadius = 3.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final Paint shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    final Path shadowPath = Path()
      ..addRRect(rrect)
      ..addRRect(rrect.inflate(blurRadius))
      ..fillType = PathFillType.evenOdd;

    final Path clipPath = Path()
      ..addRRect(rrect);

    canvas.clipPath(clipPath);
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 1),
          child: _isSearching
              ? SizedBox(
            height: 40,
            width: 240,
            child: Center(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ),
                ),
              ),
            ),
          )
              : IconButton(
            key: ValueKey<bool>(_isSearching),
            icon: const Icon(Icons.search, color: Colors.black, size: 48),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ),
        if (_isSearching)
          IconButton(
            key: ValueKey<bool>(_isSearching),
            icon: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _isSearching = false;
              });
            },
          ),
      ],
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
          ElevatedPromoWidget(),
          LatestProductsSlideshow(),
          FeaturedProductsGrid(),
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMyActivitiesSection(context),
              _buildSeparator(),
              _buildMyPurchasesSection(),
              _buildSeparator(),
              _buildMyPreOrdersSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: 1.5,
      color: Colors.grey[400],
      width: double.infinity,
    );
  }

  Widget _buildMyActivitiesSection(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY ACTIVITIES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCustomIconButton(
                  'assets/icon/cart.png',
                  'My Shipping Cart',
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CartPage()),
                        );
                      },
                ),
                _buildCustomIconButton(
                  'assets/icon/likes.png',
                  'My Likes',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LikesPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPurchasesSection() {
    const double buttonTextSize = 16.0;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY PURCHASES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCustomVerticalIconButton('assets/icon/pay.png', 'To Pay'),
                _buildCustomVerticalIconButton('assets/icon/ship.png', 'To Ship'),
                _buildCustomVerticalIconButton('assets/icon/receive.png', 'To Receive'),
                _buildCustomVerticalIconButton('assets/icon/rate.png', 'To Rate'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 165.0),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                      child: const Text('View Purchase History  >'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPreOrdersSection() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MY PRE-ORDERS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPreOrderProduct(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomIconButton(
      String imagePath,
      String label,
      VoidCallback onPressed, // Accept a callback function
      ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: _buildResizedImage(imagePath, 24, 24),
      label: Text(label, style: TextStyle(color: const Color(0xFF000000))),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: const Color(0xFFFF92B2), width: 1),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget _buildCustomVerticalIconButton(String imagePath, String label) {
    return Column(
      children: [
        _buildResizedImage(imagePath, 48, 48),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildResizedImage(String imagePath, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Image.asset(imagePath),
      ),
    );
  }

  Widget _buildPreOrderProduct() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFF92B2),
      elevation: 0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/icon/product/product1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Poppies and Rose Bouquet', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('P150', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('On September 21, 2024', style: TextStyle(fontSize: 10)),
                      const SizedBox(height: 4),
                      const Text('For Delivery', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: SizedBox(
              width: 80,
              height: 21,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Confirm'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  foregroundColor: WidgetStateProperty.all<Color>(Color(0xFFFF92B2)),
                  elevation: WidgetStateProperty.all<double>(0),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
      'title': 'Product 1',
      'price': 69.99,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Product 2',
      'price': 29.99,
    },
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
      'title': 'Product 1',
      'price': 49.99,
    },
    {
      'imageUrl': 'assets/icon/product/product2.jpg',
      'title': 'Product 2',
      'price': 59.99,
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
        title: const Text('All Products'),
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
        padding: const EdgeInsets.fromLTRB(8, 1, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar - expanded by default
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
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Messages Page'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Page'),
    );
  }
}

class ElevatedPromoWidget extends StatelessWidget {
  const ElevatedPromoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle promo click
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(16,1,16,16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Latest Promo!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Click to discover our latest offers'),
                  ],
                ),
              ),
              const Icon(Icons.local_offer, size: 40, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}

class LatestProductsSlideshow extends StatefulWidget {
  @override
  _LatestProductsSlideshowState createState() => _LatestProductsSlideshowState();
}

class _LatestProductsSlideshowState extends State<LatestProductsSlideshow> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  final Duration _scrollDuration = Duration(seconds: 3);
  final List<Map<String, dynamic>> slideshowProducts = [
    {
      'imageUrl': 'assets/icon/product/product1.jpg',
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
          duration: Duration(milliseconds: 300),
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
          Text(
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
                final endIndex = (startIndex + 2).clamp(
                    0, slideshowProducts.length);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
        'imageUrl': 'assets/icon/product/product1.jpg',
        'title': 'Product 1',
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
