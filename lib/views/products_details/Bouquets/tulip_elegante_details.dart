import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase database package
import '../../../widgets/gradient_background.dart';
import '/../user_session.dart'; // Import the user session file

class TulipEleganteDetails extends StatefulWidget {
  const TulipEleganteDetails({super.key});

  @override
  _TulipEleganteDetails createState() => _TulipEleganteDetails();
}

class _TulipEleganteDetails extends State<TulipEleganteDetails> {
  int quantity = 1;
  final DatabaseReference _database = FirebaseDatabase.instance.ref(); // Reference to Firebase Database
  final String selectedColorName = "Pink"; // Example color selection

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
        title: const Text("Tulip Elegante Bouquets"),
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
                    'assets/icon/product/bouquets/FeaturedProduct2.png',
                    width: 360,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Tulip Elegante Bouquets",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    '₱260',
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
                  TagWidget("Tulips"),
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
                          _addToCart();
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

  // Function to handle adding pre-order details to Firebase
  void _addToCart() {
    String? userId = UserSession().getUserId(); // Retrieve the user ID
    String currentDate = DateTime.now().toIso8601String(); // Get the current date in ISO format
    String imagePath = 'assets/icon/product/bouquets/FeaturedProduct2.png'; // Path to the product image

    // Create a map of the pre-order details
    Map<String, dynamic> preOrderData = {
      'name': "Tulip Elegante Bouquets",
      'price': 260, // The price you have displayed
      'quantity': quantity,
      'color': selectedColorName,
      'date': currentDate, // Include the date of pre-order
      'image': imagePath, // Include the image path
    };

    // Push the data to the Firebase database under the specified path
    _database.child('users/$userId/preorder').push().set(preOrderData).then((_) {
      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pre-order placed successfully!')),
      );
    }).catchError((error) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place pre-order: $error')),
      );
    });
  }
}

// A simple widget for product tags (Tulips, Bouquets, Onhand)
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
