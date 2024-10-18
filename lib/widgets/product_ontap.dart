import 'package:flutter/material.dart';

class ProductCardOnTap extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback onTap; // Callback function for tap

  const ProductCardOnTap({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onTap, // Pass onTap function
  });

  @override
  _ProductCardOnTapState createState() => _ProductCardOnTapState();
}

class _ProductCardOnTapState extends State<ProductCardOnTap> {
  bool isLiked = false; // Track whether the product is liked

  void toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle the like state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Calls the function when tapped
      child: Card(
        elevation: 3, // Slight elevation as in the original design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // 15px border radius for rounded corners
        ),
        color: const Color(0xFFE0D19E), // Background color as per the original card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity, // Ensures the image takes up full width
                  height: 170, // Fixed height to avoid overflow
                  padding: const EdgeInsets.all(8.0), // Padding around the image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners for the image
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.cover, // Ensures the image covers the container
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
              padding: const EdgeInsets.all(8.0), // Consistent padding for text content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 12, // Smaller font size from the original design
                    ),
                    overflow: TextOverflow.ellipsis, // Handle long text with ellipsis
                  ),
                  const SizedBox(height: 4), // Spacing between title and price
                  Text(
                    '\$${widget.price.toStringAsFixed(2)}', // Fixed dollar sign format
                    style: const TextStyle(
                      fontSize: 12, // Smaller font for price to match the design
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
