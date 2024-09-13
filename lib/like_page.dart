import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  int _likeCount = 0; // Counter for likes
  bool _isEditing = false; // Flag to check if in editing mode
  List<bool> _selectedProducts = List.generate(10, (index) => false); // Dummy product selection state
  List<Map<String, dynamic>> _products = [
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Product 1', 'price': 10.0, 'rating': 4.5},
    {'image': 'assets/icon/product/product2.jpg', 'title': 'Product 2', 'price': 15.0, 'rating': 4.0},
    {'image': 'assets/icon/product/product1.jpg', 'title': 'Product 3', 'price': 20.0, 'rating': 3.5},
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Likes'),
            const SizedBox(width: 8),
            Text(
              '$_likeCount',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF92B2),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing; // Toggle editing mode
              });
            },
            child: Text(
              _isEditing ? 'Done' : 'Edit',
              style: const TextStyle(color: Color(0xFFFF92B2)),
            ),
          ),
        ],
        elevation: 4, // Shadow for the AppBar
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 151 / 213, // Ratio for width/height of the product card
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return pc(
                image: _products[index]['image'],
                title: _products[index]['title'],
                price: _products[index]['price'],
                rating: _products[index]['rating'],
                isSelected: _selectedProducts[index],
                isEditing: _isEditing,
                onSelect: (bool? value) {
                  setState(() {
                    _selectedProducts[index] = value ?? false;
                  });
                },
                onSelectNow: () {
                  setState(() {
                    _selectedProducts[index] = !_selectedProducts[index];
                  });
                },
              );
            },
          ),
          if (_isEditing) _buildEditingNavBar(),
        ],
      ),
    );
  }

  // Editing Mode Navigation Bar
  Widget _buildEditingNavBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Select all products
                  for (int i = 0; i < _selectedProducts.length; i++) {
                    _selectedProducts[i] = true;
                  }
                });
              },
              child: const Text('Select All'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Delete selected products
                  _products.removeWhere((product) => _selectedProducts[_products.indexOf(product)]);
                  _selectedProducts = List.generate(_products.length, (index) => false);
                  _likeCount = _products.length; // Update count after deletion
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class pc extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final double rating;
  final bool isSelected;
  final bool isEditing;
  final ValueChanged<bool?> onSelect;
  final VoidCallback onSelectNow;

  const pc({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.isSelected,
    required this.isEditing,
    required this.onSelect,
    required this.onSelectNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 151,
      height: 213,
      child: Card(
        color: const Color(0xFFE0D19E),
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Removed the Checkbox
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5), // Rounded edges
                child: Image.asset(
                  image,
                  height: 150, // Square height
                  width: 150,  // Square width
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16, // Increased font size for better alignment
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          fontSize: 14, // Slightly larger font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontSize: 14), // Matching font size
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 40, // Adjusted height
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : const Color(0xFFB42323), // Change color based on selection
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -1), // Shadow above the button
                    blurRadius: 2,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: onSelectNow,
                child: Text(
                  isEditing ? (isSelected ? 'Selected' : 'Select Now') : 'Add to Cart',
                  style: TextStyle(
                    fontSize: 14, // Adjusted font size
                    color: Colors.white, // Ensure text color contrasts with button color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
