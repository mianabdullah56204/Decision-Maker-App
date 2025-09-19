import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final Color color;
  ArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    for (var r = size.height * .25; r < size.width * 1.2; r += 28) {
      final rect = Rect.fromCircle(
        center: Offset(size.width * .1, size.height * .2),
        radius: r,
      );
      canvas.drawArc(rect, -0.2, 1.3, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ArcPainter oldDelegate) => false;
}
