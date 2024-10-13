import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class EditPhonePage extends StatelessWidget {
  const EditPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Edit Phone Number',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save phone number functionality here
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(border: InputBorder.none, hintText: 'Phone Number'),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}