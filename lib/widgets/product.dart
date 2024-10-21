import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int productId;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: const Color(0xFFE0D19E), // Background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity, // Ensures the image takes up full width
            height: 170, // Fixed height to avoid overflow
            padding: const EdgeInsets.all(8.0), // Padding around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
                const SizedBox(height: 4),
                Text(
                  'P ${price.toStringAsFixed(2)}', // Fixed the Peso sign
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
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
