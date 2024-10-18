import 'package:flutter/material.dart';

import '../../../widgets/gradient_background.dart';

class LilyPrettyDetails extends StatefulWidget {
  const LilyPrettyDetails({super.key});

  @override
  _LilyPrettyDetails createState() => _LilyPrettyDetails();
}

class _LilyPrettyDetails extends State<LilyPrettyDetails> {
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
                    'assets/icon/product/bouquets/FeaturedProduct1.png',
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
                          Navigator.pop(context);
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
