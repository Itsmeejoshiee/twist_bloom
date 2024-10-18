import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, 1),
          end: Alignment(0.4, -1),
          colors: [
            Color.fromRGBO(255, 252, 227, 1.0),
            Color.fromRGBO(251, 245, 249, 1.0)
          ],
        ),
      ),
      child: child,
    );
  }
}
