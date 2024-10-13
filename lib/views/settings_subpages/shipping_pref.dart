// Shipping Preference Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class ShippingPrefPage extends StatelessWidget {
  const ShippingPrefPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Shipping Preference'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GradientBackground(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 4, // To give shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    title: Text('Shipping Address'),
                  ),
                  const Text('Region/City/District'),
                  SizedBox(
                    width: 274,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text(''), // Placeholder for address input
                        ],
                      ),
                    ),
                  ),
                  const Text('Street/Building Name'),
                  SizedBox(
                    width: 274,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text(''), // Placeholder for address input
                        ],
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text('Delivery'),
                    subtitle: Text('Standard Shipping'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
