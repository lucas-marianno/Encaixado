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
    final positions = controller.boxPositions;
    for (int i = 0; i < path.length - 1; i++) {
      canvas.drawLine(
        positions[path[i]]! + controller.center,
        positions[path[i + 1]]! + controller.center,
        pathPaint,
      );
    }

    if (controller.touchStart != null && controller.touchEnd != null) {
      canvas.drawLine(
          controller.touchStart!, controller.touchEnd!, activeLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
