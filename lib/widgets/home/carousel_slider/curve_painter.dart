import "package:flutter/material.dart";
import "package:path_drawing/path_drawing.dart";

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final Rect arcRect = Rect.fromLTWH(0, 0, size.width, size.height);

    final Path path = Path()
      ..moveTo(0, size.height / 2)
      ..arcTo(arcRect, 3.14159, 3.14159, false);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[15.0, 10.5]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
