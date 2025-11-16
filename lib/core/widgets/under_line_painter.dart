import 'package:flutter/material.dart';

class UnderlinePainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;
  final double gap;

  UnderlinePainter({
    required this.lineColor,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Offset start = Offset(0, size.height + gap);

    final Offset end = Offset(size.width, size.height + gap);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
