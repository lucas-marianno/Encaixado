import 'package:encaixado/presentation/widgets/letter_target.dart';
import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:encaixado/presentation/widgets/path_painter.dart';
import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final double size;
  final PathController controller;
  const LetterBox(this.size, {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final longOffset = size * 0.45;
    final shortOffset = size * 0.27;

    final Map<String, Offset> letterBoxPos = {
      // top
      'A': Offset(-shortOffset, -longOffset),
      'B': Offset(0, -longOffset),
      'C': Offset(shortOffset, -longOffset),
      // left
      'D': Offset(-longOffset, -shortOffset),
      'E': Offset(-longOffset, 0),
      'F': Offset(-longOffset, shortOffset),
      // right
      'G': Offset(longOffset, -shortOffset),
      'H': Offset(longOffset, 0),
      'I': Offset(longOffset, shortOffset),
      // bottom
      'J': Offset(-shortOffset, longOffset),
      'K': Offset(0, longOffset),
      'L': Offset(shortOffset, longOffset),
    };

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CustomPaint(
            foregroundPainter: PathPainter(controller),
            child: Container(
              margin: EdgeInsets.all(size * 0.05),
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(width: 2),
              ),
            ),
          ),
          for (var entry in letterBoxPos.entries)
            LetterTarget(
              label: entry.key,
              letterOffsetFromCenter: entry.value,
              center: Offset(size / 2, size / 2),
              controller: controller,
            )
        ],
      ),
    );
  }
}
