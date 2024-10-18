import 'package:flutter/material.dart';

class InnerShadowPainter extends CustomPainter {
  final Color shadowColor;
  final double blurRadius;
  final double borderRadius;

  InnerShadowPainter({
    this.shadowColor = Colors.black,
    this.blurRadius = 3.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect =
    RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final Paint shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    final Path shadowPath = Path()
      ..addRRect(rrect)
      ..addRRect(rrect.inflate(blurRadius))
      ..fillType = PathFillType.evenOdd;

    final Path clipPath = Path()..addRRect(rrect);

    canvas.clipPath(clipPath);
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}