import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:twist_bloom/widgets/gradient_background.dart';
import '/../user_session.dart'; // Adjust import according to your file structure

class LilyDetails extends StatefulWidget {
  const LilyDetails({super.key});

  @override
  _LilyDetailsState createState() => _LilyDetailsState();
}

class _LilyDetailsState extends State<LilyDetails> {
  late final String userId; // Use late to initialize later
  final List<Map<String, dynamic>> colors = [
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Golden', 'color': Colors.amber},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Baby Blue', 'color': Colors.lightBlue},
    {'name': 'Cobalt', 'color': Colors.blue},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Violet', 'color': Colors.deepPurple},
    {'name': 'Indigo', 'color': Colors.indigo},
    {'name': 'Fuchsia', 'color': Colors.pink},
    {'name': 'Pink', 'color': Colors.pinkAccent},
    {'name': 'White', 'color': Colors.white},
  ];

  String selectedColorName = 'Red'; // Default selected color
  int quantity = 1;
  final String flowerName = 'Lily';
  final double price = 65.0;

  @override
  void initState() {
    super.initState();
    userId = UserSession().getUserId() ?? ''; // Get user ID from session
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFAFA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Lily'),
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
                    'assets/icon/product/flowers/lily.png',
                    width: 360,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Lily',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildPriceRow(),
              const SizedBox(height: 8),
              _buildTagsRow(),
              const SizedBox(height: 16),
              const Text(
                'Lorem ipsum odor amet, consectetur adipiscing elit.',
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              _buildCustomizeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildPriceRow() {
    return const Row(
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
    );
  }

  Row _buildTagsRow() {
    return const Row(
      children: [
        TagWidget('Lily'),
        SizedBox(width: 7),
        TagWidget('Stem'),
        SizedBox(width: 7),
        TagWidget('Pre-order'),
      ],
    );
  }

  Center _buildCustomizeButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () => _showCustomizationSheet(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF92B2),
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Text('CUSTOMIZE',
            style: TextStyle(fontSize: 20, color: Color(0xFF59333E))),
      ),
    );
  }

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
                  _buildColorOptions(setModalState),
                  const SizedBox(height: 16),
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildQuantityControls(setModalState),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  GridView _buildColorOptions(StateSetter setModalState) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
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
              selectedColorName = colorInfo['name']; // Update selected color
            });
          },
          child: _buildColorOptionItem(colorInfo),
        );
      },
    );
  }

  Container _buildColorOptionItem(Map<String, dynamic> colorInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: selectedColorName == colorInfo['name']
            ? const Color(0xFFE0D19E)
            : const Color(0xFFB3B3B3).withOpacity(.30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildColorCircle(colorInfo),
          const SizedBox(width: 8),
          _buildColorNameText(colorInfo),
        ],
      ),
    );
  }

  Container _buildColorCircle(Map<String, dynamic> colorInfo) {
    return Container(
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
    );
  }

  Text _buildColorNameText(Map<String, dynamic> colorInfo) {
    return Text(
      colorInfo['name'],
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: selectedColorName == colorInfo['name']
            ? Colors.black
            : Colors.grey.shade700,
      ),
    );
  }

  Row _buildQuantityControls(StateSetter setModalState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setModalState(() {
                  if (quantity > 1) quantity--;
                });
              },
            ),
            Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setModalState(() {
                  quantity++;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            _preOrder();
            Navigator.pop(context); // Close the modal
          },
          child: const Text('Pre-order'),
        ),
      ],
    );
  }

  Future<void> _preOrder() async {
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('/users/$userId/preorder');

    // Format the current date
    String formattedDate = DateTime.now().toIso8601String();

    // Product image path
    String productImage = 'assets/icon/product/flowers/lily.png';

    // Push new order to Firebase
    await dbRef.push().set({
      'name': flowerName,
      'price': price,
      'quantity': quantity,
      'color': selectedColorName,
      'date': formattedDate,
      'image': productImage,
    });

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
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
