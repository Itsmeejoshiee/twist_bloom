import 'package:flutter/material.dart';

class ProductCardOnTap extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Calls the function when tapped
      child: Card(
        elevation: 3, // Slight elevation as in the original design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // 15px border radius for rounded corners
        ),
        color: const Color(0xFFE0D19E), // Background color as per the original card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, // Ensures the image takes up full width
              height: 170, // Fixed height to avoid overflow
              padding: const EdgeInsets.all(8.0), // Padding around the image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners for the image
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover, // Ensures the image covers the container
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // Consistent padding for text content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12, // Smaller font size from the original design
                    ),
                    overflow: TextOverflow.ellipsis, // Handle long text with ellipsis
                  ),
                  const SizedBox(height: 4), // Spacing between title and price
                  Text(
                    '\$${price.toStringAsFixed(2)}', // Fixed dollar sign format
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
    super.key,
    required this.imageUrl,
  });

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
