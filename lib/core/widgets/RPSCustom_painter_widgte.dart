
//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.01066667,size.height*0.2631579);
    path_0.cubicTo(size.width*0.01066667,size.height*0.2367330,size.width*0.02260573,size.height*0.2153110,size.width*0.03733333,size.height*0.2153110);
    path_0.lineTo(size.width*0.06933333,size.height*0.2153110);
    path_0.cubicTo(size.width*0.08406080,size.height*0.2153110,size.width*0.09600000,size.height*0.1938890,size.width*0.09600000,size.height*0.1674641);
    path_0.lineTo(size.width*0.09600000,0);
    path_0.lineTo(size.width*0.1524707,size.height*0.1899804);
    path_0.cubicTo(size.width*0.1571051,size.height*0.2055718,size.width*0.1661517,size.height*0.2153110,size.width*0.1760000,size.height*0.2153110);
    path_0.lineTo(size.width*0.9626667,size.height*0.2153110);
    path_0.cubicTo(size.width*0.9773947,size.height*0.2153110,size.width*0.9893333,size.height*0.2367330,size.width*0.9893333,size.height*0.2631579);
    path_0.lineTo(size.width*0.9893333,size.height*0.9138756);
    path_0.cubicTo(size.width*0.9893333,size.height*0.9403014,size.width*0.9773947,size.height*0.9617225,size.width*0.9626667,size.height*0.9617225);
    path_0.lineTo(size.width*0.03733333,size.height*0.9617225);
    path_0.cubicTo(size.width*0.02260576,size.height*0.9617225,size.width*0.01066667,size.height*0.9403014,size.width*0.01066667,size.height*0.9138756);
    path_0.lineTo(size.width*0.01066667,size.height*0.2631579);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}