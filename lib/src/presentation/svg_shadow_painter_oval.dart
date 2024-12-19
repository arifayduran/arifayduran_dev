import 'package:flutter/material.dart';

class SvgShadowPainterOval extends CustomPainter {
  final Color shadowColor;
  final bool shouldReverse;
  final double leftOffset;
  final double topOffset;
  final double blur;
  final double alpha;
  SvgShadowPainterOval(
      {required this.shadowColor,
      required this.shouldReverse,
      this.leftOffset = 0,
      this.topOffset = 20,
      this.blur = 30,
      this.alpha = .3});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = shadowColor.withValues(alpha: alpha)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    final Path shadowPath = Path()
      ..addOval(Rect.fromLTWH(leftOffset,
          shouldReverse ? topOffset : -topOffset, size.width, size.height));

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
