import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, 1),
          end: Alignment(0.4, -1),
          colors: [
            Color.fromRGBO(224, 209, 158, 0.14),
            Color.fromRGBO(255, 252, 237, 1.0)
          ],
        ),
      ),
      child: child,
    );
  }
}
