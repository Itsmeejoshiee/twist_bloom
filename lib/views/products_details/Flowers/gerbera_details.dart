import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'package:firebase_core/firebase_core.dart';

// TagWidget definition
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


class GerberaDetails extends StatefulWidget {
  const GerberaDetails({super.key});

  @override
  _GerberaDetails createState() => _GerberaDetails();
}

class _GerberaDetails extends State<GerberaDetails> {
  // Firebase database reference
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users/user1/preorder');

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
        title: const Text('Gerbera Daisy'),
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
                    'assets/icon/product/flowers/gerbera.png',
                    width: 360,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Gerbera Daisy',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    '₱70',
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
              Row(
                children: [
                  TagWidget('Gerbera Daisy'), // Custom color for Gerbera Daisy
                  SizedBox(width: 7),
                  TagWidget('Stem'), // Custom color for Stem
                  SizedBox(width: 7),
                  TagWidget('Pre-order'), // Custom color for Pre-order
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
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('CUSTOMIZE', style: TextStyle(fontSize: 20, color: Color(0xFF59333E))),
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      final colorInfo = colors[index];
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            setState(() {
                              selectedColorName = colorInfo['name'];
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
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorInfo['color'],
                                  border: Border.all(
                                    color: selectedColorName == colorInfo['name']
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setModalState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {
                              setModalState(() {
                                quantity++;
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _addToPreOrder();
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF92B2),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        child: const Text('Add to Pre-order', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Function to add the pre-order data to Firebase
  void _addToPreOrder() {
    final preOrderData = {
      'name': 'Gerbera Daisy',
      'color': selectedColorName,
      'quantity': quantity,
    };

    _dbRef.push().set(preOrderData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Pre-order!')));
    }).catchError((error) {
      print('Error adding to pre-order: $error');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add to Pre-order')));
    });
  }
}

// Main function to run the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MaterialApp(home: GerberaDetails()));
}
