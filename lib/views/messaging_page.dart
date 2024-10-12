import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart'; // Import your GradientBackground widget

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientBackground(
      child: Center(
        child: Text('Messages Page'),
      ),
    );
  }
}
