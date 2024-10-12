import 'package:flutter/material.dart';

class FlowerNameDetails extends StatelessWidget {
  final String flowerName;

  const FlowerNameDetails({Key? key, required this.flowerName}) : super(key: key);

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
