import 'package:flutter/material.dart';

enum HighlightPainterStyle {
  none,
  highlightLeading,
  highlightTrailing,
  highlightAll,
}

class HighlightPainter extends CustomPainter {
  HighlightPainter({
    this.color,
    this.style = HighlightPainterStyle.none,
    this.textDirection,
  });

  final Color? color;
  final HighlightPainterStyle style;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    if (style == HighlightPainterStyle.none) {
      return;
    }

    final Paint paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    final Rect rectLeft = Rect.fromLTWH(0, 0, size.width / 2, size.height);
    final Rect rectRight =
    Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height);

    switch (style) {
      case HighlightPainterStyle.highlightTrailing:
        canvas.drawRect(
          textDirection == TextDirection.ltr ? rectRight : rectLeft,
          paint,
        );
        break;
      case HighlightPainterStyle.highlightLeading:
        canvas.drawRect(
          textDirection == TextDirection.ltr ? rectLeft : rectRight,
          paint,
        );
        break;
      case HighlightPainterStyle.highlightAll:
        canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          paint,
        );
        break;
      default:
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
