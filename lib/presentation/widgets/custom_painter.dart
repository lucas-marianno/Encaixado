import 'dart:math';

import 'package:flutter/material.dart';

class LinePainer extends CustomPainter {
  final Offset? start;
  final Offset? touch;

  final List<List<Offset>> path;

  LinePainer(this.start, this.touch, {required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final activeLinePaint = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    print('path.length = ${path.length}');
    for (List line in path) {
      canvas.drawLine(line[0], line[1], pathPaint);
    }

    if (start != null && touch != null) {
      canvas.drawLine(start!, touch!, activeLinePaint);
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
