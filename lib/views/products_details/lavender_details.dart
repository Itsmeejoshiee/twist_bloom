import 'package:flutter/material.dart';

class LavenderDetails extends StatefulWidget {
  const LavenderDetails({Key? key}) : super(key: key);

  @override
  _LavenderDetails createState() => _LavenderDetails();
}

class _LavenderDetails extends State<LavenderDetails> {
  List<String> colors = ['Red', 'Yellow', 'Purple', 'Fuschia', 'Orange', 'Baby Blue', 'Violet', 'Pink', 'Golden', 'Cobalt', 'Indigo', 'White'];
  String selectedColor = 'Red';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Lavender'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/icon/product/flower1.jpg', // Placeholder image
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Lavender',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '₱45 for 1 stem',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                TagWidget('Lavender'),
                SizedBox(width: 5),
                TagWidget('Filler'),
                SizedBox(width: 5),
                TagWidget('Pre-order'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Lorem ipsum odor amet, consectetur adipiscing elit. Maecenas varius fusce efficitur habitasse sollicitudin ipsum nunc. Adipiscing praesent mus curae cras malesuada ridiculus rutrum.',
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showCustomizationSheet();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF92B2), // Pink color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('CUSTOMIZE', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the BottomSheet with customization options
  void _showCustomizationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
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
              GridView.builder(
                shrinkWrap: true,
                itemCount: colors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = colors[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: selectedColor == colors[index] ? Colors.blueAccent : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Text(
                          colors[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedColor == colors[index] ? Colors.white : Colors.black,
                          ),
                        ),
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
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add to cart logic
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF92B2), // Pink color
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Add', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

// A simple widget for product tags (Lavender, Filler, Pre-order)
class TagWidget extends StatelessWidget {
  final String label;

  const TagWidget(this.label, {Key? key}) : super(key: key);

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
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
