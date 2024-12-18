import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database
import 'package:intl/intl.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '/../user_session.dart'; // Import UserSession for user ID retrieval

class TulipDetails extends StatefulWidget {
  const TulipDetails({super.key});

  @override
  _TulipDetails createState() => _TulipDetails();
}

class _TulipDetails extends State<TulipDetails> {
  // List of colors with corresponding display color and name
  List<Map<String, dynamic>> colors = [
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Golden', 'color': Colors.amber},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Baby Blue', 'color': Colors.lightBlue},
    {'name': 'Cobalt', 'color': Colors.blue},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Violet', 'color': Colors.deepPurple},
    {'name': 'Indigo', 'color': Colors.indigo},
    {'name': 'Fuschia', 'color': Colors.pink},
    {'name': 'Pink', 'color': Colors.pinkAccent},
    {'name': 'White', 'color': Colors.white},
  ];

  String selectedColorName = 'Red'; // Default selected color
  int quantity = 1;
  final double price = 65.0; // Price per stem

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
        title: const Text('Tulip'),
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
                    'assets/icon/product/flowers/tulip.png',
                    width: 360,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tulip',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    'P65',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFFF92B2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Per stem',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  TagWidget('Tulip'),
                  SizedBox(width: 7),
                  TagWidget('Stem'),
                  SizedBox(width: 7),
                  TagWidget('Pre-order'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Lorem ipsum odor amet, consectetur adipiscing elit.',
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showCustomizationSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF92B2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('CUSTOMIZE',
                      style: TextStyle(fontSize: 20, color: Color(0xFF59333E))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the BottomSheet with customization options
  void _showCustomizationSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: const Color(0xFFFFFAEA),
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder to track changes within the modal
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Color',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // The GridView for color options
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: colors.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 columns like the design
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          3, // Adjust ratio to make the circles with labels fit
                    ),
                    itemBuilder: (context, index) {
                      final colorInfo = colors[index];
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            setState(() {
                              selectedColorName = colorInfo[
                                  'name']; // Update in both modal and parent
                            });
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: selectedColorName == colorInfo['name']
                                ? const Color(0xFFE0D19E)
                                : const Color(0xFFB3B3B3).withOpacity(.30),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              // Circle representing the color
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorInfo['color'],
                                  border: Border.all(
                                    color:
                                        selectedColorName == colorInfo['name']
                                            ? const Color(0xFFE0D19E)
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                colorInfo['name'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: selectedColorName == colorInfo['name']
                                      ? Colors.black
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Align the quantity, cart, and pre-order button in the same row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setModalState(() {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              });
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setModalState(() {
                                setState(() {
                                  quantity++;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _addToCart(); // Handle pre-order logic
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
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Function to add the pre-order details to Firebase
  void _addToCart() async {
    final database =
        FirebaseDatabase.instance.ref(); // Get the database reference

    // Get the current date and time in a readable format
    final String preOrderDate = DateTime.now().toIso8601String();

    // Get the user ID from UserSession
    String? userId = UserSession().getUserId();

    // Create a map for the pre-order data
    Map<String, dynamic> preOrderData = {
      'name': 'Tulip',
      'color': selectedColorName,
      'quantity': quantity,
      'price': price,
      'pre_order_date': preOrderDate,
      'image': 'assets/icon/product/flowers/tulip.png' // Use the image path
    };

    // Push the data to the correct path in the database
    await database
        .child('users/$userId/preorder')
        .push()
        .set(preOrderData)
        .then((_) {
      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pre-order added to cart successfully!')),
      );
    }).catchError((error) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add pre-order: $error')),
      );
    });
  }
}

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
