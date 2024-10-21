import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../widgets/gradient_background.dart';
import '/../user_session.dart'; // Import UserSession

class LavenderLoverDetails extends StatefulWidget {
  const LavenderLoverDetails({super.key});

  @override
  _LavenderLoverDetails createState() => _LavenderLoverDetails();
}

class _LavenderLoverDetails extends State<LavenderLoverDetails> {
  int quantity = 1;
  final String productName = "Lavender Lover Bouquets";
  final int productPrice = 200;
  final String productColor =
      'Lavender'; // Example color, you can modify this as needed
  final String productImage =
      'assets/icon/product/bouquets/FeaturedProduct3.png'; // Path to product image

  // Reference to the Firebase Realtime Database
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  // Function to handle pre-order logic
  void _handlePreOrder() {
    String? userId = UserSession().getUserId(); // Retrieve user ID
    String currentDate =
        DateTime.now().toIso8601String(); // Get current date in ISO format

    // Store data in the Firebase Realtime Database
    database.child('users/$userId/preorder').push().set({
      'name': productName,
      'price': productPrice,
      'quantity': quantity,
      'color': productColor,
      'date': currentDate, // Store the pre-order date
      'image': productImage, // Store the product image path
    }).then((_) {
      // Optionally show a success message or navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pre-order added successfully!')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

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
        title: const Text("Lavender Lover Bouquets"),
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
                    productImage, // Use the product image path here
                    width: 360,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Lavender Lover Bouquets",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    'P200',
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
                  TagWidget("Daisy"),
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
                        onPressed: _handlePreOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF92B2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Add to Cart',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF59333E))),
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
}

// A simple widget for product tags (Lavender, Filler, Pre-order)
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
