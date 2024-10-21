import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../user_session.dart'; // Import your user session for user ID

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  int _likeCount = 0; // Counter for likes
  bool _isEditing = false; // Flag to check if in editing mode
  List<bool> _selectedProducts = []; // Product selection state
  List<Map<String, dynamic>> _likedProducts = []; // List to store liked products
  String? userId; // Store the current user's ID

  @override
  void initState() {
    super.initState();
    userId = UserSession().getUserId(); // Fetch userId from user session
    _fetchLikedProducts();
  }

  Future<void> _fetchLikedProducts() async {
    if (userId == null) return; // Check if userId is not null

    DatabaseReference ref = FirebaseDatabase.instance.ref('users/$userId/likes'); // Adjust path for user-specific likes
    DatabaseEvent event = await ref.once(); // Use `once` to get a single snapshot
    DataSnapshot snapshot = event.snapshot; // Get the snapshot from the event

    if (snapshot.exists) {
      List<Map<String, dynamic>> fetchedProducts = [];
      // Ensure that the snapshot value is a Map
      if (snapshot.value is Map) {
        final likesMap = snapshot.value as Map;
        for (var entry in likesMap.entries) {
          // Each entry corresponds to a liked product
          if (entry.value is Map) {
            Map<String, dynamic> product = Map<String, dynamic>.from(entry.value as Map);
            // Convert price to double if it is an int
            if (product['price'] is int) {
              product['price'] = (product['price'] as int).toDouble(); // Convert int to double
            }
            fetchedProducts.add(product);
          }
        }
      }
      setState(() {
        _likedProducts = fetchedProducts; // Store liked products
        _selectedProducts = List.generate(_likedProducts.length, (index) => false); // Initialize selection state
        _likeCount = _likedProducts.length; // Set like count based on fetched products
      });
    }
  }

  Future<void> _deleteSelectedProducts() async {
    if (userId == null) return; // Check if userId is not null

    DatabaseReference ref = FirebaseDatabase.instance.ref('users/$userId/likes'); // Reference to user-specific likes

    // Loop through selected products and delete them from Firebase
    for (int i = 0; i < _likedProducts.length; i++) {
      if (_selectedProducts[i]) {
        // Get the product ID from the liked products list
        String productId = _likedProducts[i]['productId'].toString(); // Assuming each liked product has a unique 'id' field
        String productIdKey = 'product_$productId'; // Create the unique key for Firebase
        print('Deleting product with ID: $productIdKey'); // Debug statement

        // Remove the product from Firebase
        await ref.child(productIdKey).remove().catchError((error) {
          print('Error deleting product: $error'); // Catch and print any errors
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xFFFDFAFA), // Make app bar transparent
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
        body: GradientBackground(
          child: Stack(
            children: [
              _likedProducts.isNotEmpty // Check if there are liked products
                  ? GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 151 / 213, // Ratio for width/height of the product card
                ),
                itemCount: _likedProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    image: _likedProducts[index]['image'],
                    title: _likedProducts[index]['title'],
                    price: _likedProducts[index]['price'],
                    rating: 4.5, // Example rating, replace with actual data if available
                    isSelected: _selectedProducts[index],
                    isEditing: _isEditing,
                    onSelect: (bool? value) {
                      setState(() {
                        _selectedProducts[index] = value ?? false;
                      });
                    },
                    onLike: () {
                      setState(() {
                        // Add or remove product from liked products
                        if (_likedProducts.contains(_likedProducts[index])) {
                          _likedProducts.remove(_likedProducts[index]);
                          _likeCount--; // Decrease like count
                        } else {
                          _likedProducts.add(_likedProducts[index]);
                          _likeCount++; // Increase like count
                        }
                      });
                    },
                  );
                },
              )
                  : const Center(child: Text('No liked products available')), // Show message if no liked products
              if (_isEditing) _buildEditingNavBar(),
            ],
          ),
        ),
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
              onPressed: () async {
                await _deleteSelectedProducts(); // Call delete function
                setState(() {
                  // Update local state after deletion
                  _likedProducts.removeWhere((product) => _selectedProducts[_likedProducts.indexOf(product)]);
                  _selectedProducts = List.generate(_likedProducts.length, (index) => false);
                  _likeCount = _likedProducts.length; // Update count after deletion
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



class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final double rating;
  final bool isSelected;
  final bool isEditing;
  final ValueChanged<bool?> onSelect;
  final VoidCallback onLike;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
    required this.isSelected,
    required this.isEditing,
    required this.onSelect,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    blurRadius: 3,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: onLike,
                child: Text(
                  isEditing ? 'Remove' : 'Like', // Show different text based on editing mode
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
