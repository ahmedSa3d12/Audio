import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final Color color;

  MyPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = color;

    path = Path();
    path.lineTo(size.width / 4, 0);
    path.cubicTo(size.width / 4, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.88, size.width, size.height * 0.88);
    path.cubicTo(size.width, size.height * 0.95, size.width * 0.98, size.height, size.width * 0.95, size.height);
    path.cubicTo(size.width * 0.95, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, size.width / 4, 0, size.width / 4, 0);
    path.cubicTo(size.width / 4, 0, size.width / 4, 0, size.width / 4, 0);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}