import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../user_session.dart'; // Import the user session file

class ProductCardOnTap extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int productId;
  final VoidCallback onTap; // Callback function for tap
  final Function(Map<String, dynamic>)?
      onLike; // Optional callback for liking a product

  const ProductCardOnTap({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    required this.onTap, // Pass onTap function
    this.onLike, // Make onLike optional
  }) : super(key: key);

  @override
  _ProductCardOnTapState createState() => _ProductCardOnTapState();
}

class _ProductCardOnTapState extends State<ProductCardOnTap> {
  bool isLiked = false; // Track whether the product is liked

  // Firebase Database reference
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    checkIfLiked(); // Check if the product is already liked
  }

  void checkIfLiked() async {
    final userId =
        UserSession().getUserId(); // Get userId from the UserSession instance
    if (userId != null) {
      final userLikesRef =
          dbRef.child('users/$userId/likes/product_${widget.productId}');

      try {
        // Fetch the DatabaseEvent from the database
        DatabaseEvent event = await userLikesRef.once();

        // Get the DataSnapshot from the DatabaseEvent
        DataSnapshot snapshot = event.snapshot;

        // Set the state based on the existence of data in the snapshot
        setState(() {
          isLiked = snapshot.exists; // Check if the snapshot has data
        });
      } catch (error) {
        print(
            'Error checking if product is liked: $error'); // Handle any errors
      }
    } else {
      print('User ID is null'); // Debugging output if userId is null
    }
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle the like state
      if (isLiked) {
        // Create a product map to send when liked
        final product = {
          'image': widget.imageUrl,
          'title': widget.title,
          'price': widget.price,
          'productId': widget.productId,
        };
        // Notify the like action with product details
        widget.onLike?.call(product);

        // Add to Firebase Realtime Database
        addToLikes(product);
      } else {
        // Remove from likes if unliked
        removeFromLikes(widget.productId);
      }
    });
  }

  // Method to add liked product to the user's likes in the database
  Future<void> addToLikes(Map<String, dynamic> product) async {
    final userId =
        UserSession().getUserId(); // Get userId from the UserSession instance
    if (userId != null) {
      try {
        final userLikesRef = dbRef.child('users/$userId/likes');
        final productIdKey =
            'product_${product['productId']}'; // Unique key for the product
        await userLikesRef.child(productIdKey).set(product); // Save the product
        print('Product added to likes: $productIdKey'); // Debugging output
      } catch (e) {
        print('Error adding product to likes: $e'); // Log the error
      }
    } else {
      print('User ID is null'); // Debugging output
    }
  }

  // Method to remove liked product from the user's likes
  Future<void> removeFromLikes(int productId) async {
    final userId =
        UserSession().getUserId(); // Get userId from the UserSession instance
    if (userId != null) {
      try {
        final userLikesRef = dbRef.child('users/$userId/likes');
        final productIdKey = 'product_$productId'; // Unique key for the product
        await userLikesRef.child(productIdKey).remove(); // Remove the product
        print('Product removed from likes: $productIdKey'); // Debugging output
      } catch (e) {
        print('Error removing product from likes: $e'); // Log the error
      }
    } else {
      print('User ID is null'); // Debugging output
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Calls the function when tapped
      child: Card(
        elevation: 3, // Slight elevation as in the original design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // 15px border radius for rounded corners
        ),
        color: const Color(
            0xFFE0D19E), // Background color as per the original card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width:
                      double.infinity, // Ensures the image takes up full width
                  height: 170, // Fixed height to avoid overflow
                  padding:
                      const EdgeInsets.all(8.0), // Padding around the image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Rounded corners for the image
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit
                          .cover, // Ensures the image covers the container
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: toggleLike, // Toggle the like state when pressed
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(
                  8.0), // Consistent padding for text content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize:
                          12, // Smaller font size from the original design
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Handle long text with ellipsis
                  ),
                  const SizedBox(height: 4), // Spacing between title and price
                  Text(
                    'P ${widget.price.toStringAsFixed(2)}', // Fixed dollar sign format
                    style: const TextStyle(
                      fontSize:
                          12, // Smaller font for price to match the design
                      color: Colors.green, // Green color for the price
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSquareCard extends StatelessWidget {
  final String imageUrl;

  const ProductSquareCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124, // Full width of the parent container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0), // Circular sides
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 8.0, // Shadow blur radius
            offset: const Offset(0, 4), // Shadow offset
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
