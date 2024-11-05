import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final PathController controller;

  PathPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final activeLinePaint = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final path = controller.path;
    final positions = controller.lettersPositioned;
    for (int i = 0; i < path.length - 1; i++) {
      canvas.drawLine(
        positions[path[i]]!,
        positions[path[i + 1]]!,
        pathPaint,
      );
    }

    if (controller.touchStart != null && controller.touchPoint != Offset.zero) {
      canvas.drawLine(
          controller.touchStart!, controller.touchPoint, activeLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
