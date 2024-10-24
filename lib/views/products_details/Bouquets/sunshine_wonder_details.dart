import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../widgets/gradient_background.dart';
import '/../user_session.dart'; // Import the UserSession class

class SunshineWonderDetails extends StatefulWidget {
  const SunshineWonderDetails({super.key});

  @override
  _SunshineWonderDetails createState() => _SunshineWonderDetails();
}

class _SunshineWonderDetails extends State<SunshineWonderDetails> {
  int quantity = 1;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final String bouquetName = "Sunshine Wonder Bouquets";
  final double bouquetPrice = 200.0;
  String selectedColor =
      "Yellow"; // Default color (you can modify this as needed)
  final String productImage =
      'assets/icon/product/bouquets/FeaturedProduct4.png'; // Path to the product image

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
        title: const Text("Sunshine Wonder Bouquets"),
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
                "Sunshine Wonder Bouquets",
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
                  TagWidget("Sunflower"),
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
                          _addPreOrderToFirebase();
                          Navigator.pop(context);
                        },
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

  // Function to add pre-order details to Firebase
  void _addPreOrderToFirebase() {
    String? userId = UserSession().getUserId(); // Get the user ID dynamically
    String preOrderId =
        _databaseReference.child('users/$userId/preorder').push().key!;

    // Get the current date
    String currentDate =
        DateTime.now().toIso8601String(); // Use ISO 8601 format for consistency

    Map<String, dynamic> preOrderDetails = {
      'name': bouquetName,
      'price': bouquetPrice,
      'quantity': quantity,
      'color': selectedColor,
      'date': currentDate, // Include the pre-order date
      'image': productImage, // Include the image path
    };

    _databaseReference
        .child('users/$userId/preorder/$preOrderId')
        .set(preOrderDetails)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pre-order added successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add pre-order: $error')),
      );
    });
  }
}

// A simple widget for product tags (Sunflower, Bouquets, Onhand)
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
