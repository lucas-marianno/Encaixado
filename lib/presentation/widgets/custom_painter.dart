import 'dart:math';

import 'package:flutter/material.dart';

class LinePainer extends CustomPainter {
  final Offset? start;
  final Offset? touch;
  final Offset? end;

  LinePainer(this.start, this.touch, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    if (start != null && touch != null) {
      canvas.drawLine(start!, touch!, paint);
    } else if (start != null && end != null) {
      canvas.drawLine(start!, end!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);

    //body
    final bodyPaint = Paint()
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, Offset(center.dx, center.dy + 200), bodyPaint);
    canvas.drawLine(Offset(center.dx, center.dy + 80),
        Offset(center.dx - 60, center.dy + 100), bodyPaint);
    canvas.drawLine(Offset(center.dx, center.dy + 80),
        Offset(center.dx + 60, center.dy + 100), bodyPaint);
    canvas.drawLine(Offset(center.dx, center.dy + 200),
        Offset(center.dx + 40, center.dy + 270), bodyPaint);
    canvas.drawLine(Offset(center.dx, center.dy + 200),
        Offset(center.dx - 40, center.dy + 270), bodyPaint);

    // head
    canvas.drawCircle(center, 60, Paint()..color = Colors.yellow);
    canvas.drawCircle(
      center,
      60,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // eyes
    canvas.drawCircle(Offset(center.dx + 25, center.dy - 20), 10, Paint());
    canvas.drawCircle(Offset(center.dx - 25, center.dy - 20), 10, Paint());
    canvas.drawCircle(Offset(center.dx, center.dy - 30), 10, Paint());

    // mouth
    final rect = Rect.fromLTRB(
        center.dx - 40, center.dy - 15, center.dx + 40, center.dy + 35);
    canvas.drawArc(
      rect,
      0,
      pi,
      false,
      Paint()
        // ..color = Colors.pink
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
