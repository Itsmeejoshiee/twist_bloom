import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database
import 'package:intl/intl.dart'; // Import for date formatting
import '../../../widgets/gradient_background.dart';
import '/../user_session.dart'; // Import your user session

class LilyPrettyDetails extends StatefulWidget {
  const LilyPrettyDetails({super.key});

  @override
  _LilyPrettyDetails createState() => _LilyPrettyDetails();
}

class _LilyPrettyDetails extends State<LilyPrettyDetails> {
  int quantity = 1;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref(); // Reference to Firebase Database
  final String itemName = "Lily Pretty Bouquets"; // Item name
  final double itemPrice = 200; // Item price
  String selectedColor = "Red"; // Default selected color
  final String productImage = 'assets/icon/product/bouquets/FeaturedProduct1.png'; // Product image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFAFA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Lily Pretty Bouquets"),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    productImage,
                    width: 360,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Lily Pretty Bouquets",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    '₱200',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFFF92B2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  TagWidget("Lily"),
                  SizedBox(width: 7),
                  TagWidget('Bouquets'),
                  SizedBox(width: 7),
                  TagWidget('Onhand'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Lorem ipsum odor amet, consectetur adipiscing elit.',
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              // Quantity and action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle pre-order logic
                          _addToPreOrder(); // Call the function to add to pre-order
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF92B2),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Add to Cart', style: TextStyle(fontSize: 16, color: Color(0xFF59333E))),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to add pre-order details to Firebase Realtime Database
  Future<void> _addToPreOrder() async {
    try {
      String? userId = UserSession().getUserId(); // Get user ID from session
      String orderDate = DateTime.now().toIso8601String(); // Format the current date
      // Create a new order object
      Map<String, dynamic> orderData = {
        'name': itemName,
        'price': itemPrice,
        'quantity': quantity,
        'color': selectedColor,
        'date': orderDate, // Add the date of the pre-order
        'image': productImage, // Add the image of the product
      };
      // Push the new order data to Firebase
      await _dbRef.child('users/$userId/preorder').push().set(orderData);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pre-order added successfully!')));
      Navigator.pop(context); // Optionally navigate back
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add pre-order: $e')));
    }
  }
}

// A simple widget for product tags (Lily, Bouquets, Onhand)
class TagWidget extends StatelessWidget {
  final String label;

  const TagWidget(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, color: Color(0xFF59333E)),
      ),
    );
  }
}
