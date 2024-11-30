import 'package:flutter/material.dart';

import 'letter_target.dart';
import 'package:encaixado/presentation/pages/letter_boxed/helpers/helpers.dart';

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
