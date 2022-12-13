import 'package:final_proj/components/colors.dart';
import 'package:flutter/material.dart';

class DarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = backgroundScreen;
    canvas.drawPath(mainBackground, paint);

    paint.shader =
        LinearGradient(colors: [Color(0xfffDBB3B1), Color(0xffA67F8E)])
            .createShader(new Rect.fromCircle(
      center: new Offset(165.0, 35.0),
      radius: 180.0,
    ));
    canvas.drawCircle(Offset(50, 0), 550, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
