import 'package:flutter/material.dart';

class FlowerNameDetails extends StatelessWidget {
  final String flowerName;

  const FlowerNameDetails({super.key, required this.flowerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(flowerName),
      ),
      body: Center(
        child: Text(
          'Details about $flowerName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
