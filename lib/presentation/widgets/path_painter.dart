import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final PathController controller;

  PathPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final activeLinePaint = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    for (List line in controller.path) {
      canvas.drawLine(line[0], line[1], pathPaint);
    }

    if (controller.startPos != null && controller.touchPos != null) {
      canvas.drawLine(
          controller.startPos!, controller.touchPos!, activeLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
