import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final PathController controller;

  PathPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final currentWordPaint = Paint()
      ..color = const Color.fromARGB(130, 233, 30, 98)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final historyPaint = Paint()
      ..color = const Color.fromARGB(180, 255, 255, 255)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final touchLinePaint = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final positions = controller.lettersPositioned;

    // history word
    for (var word in controller.wordList) {
      for (int i = 0; i < word.length - 1; i++) {
        canvas.drawLine(
          positions[word[i]]!,
          positions[word[i + 1]]!,
          historyPaint,
        );
      }
    }
    // current word
    final path = controller.currentWord;
    for (int i = 0; i < path.length - 1; i++) {
      canvas.drawLine(
        positions[path[i]]!,
        positions[path[i + 1]]!,
        currentWordPaint,
      );
    }

    // touch line
    if (controller.touchStart != null && controller.touchPoint != Offset.zero) {
      canvas.drawLine(
          controller.touchStart!, controller.touchPoint, touchLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
