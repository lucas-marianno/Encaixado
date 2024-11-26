import 'package:encaixado/presentation/widgets/letter_target.dart';
import 'package:encaixado/presentation/path_controller.dart';
import 'package:encaixado/presentation/widgets/path_painter.dart';
import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final PathController controller;
  const LetterBox({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final size = controller.boxSize;

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
          for (String letter in controller.box.letterBox.join().split(''))
            LetterTarget(letter, controller: controller)
        ],
      ),
    );
  }
}
