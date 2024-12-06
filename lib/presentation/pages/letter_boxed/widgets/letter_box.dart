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
            foregroundPainter: PathPainter(
              controller,
              Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Container(
              margin: EdgeInsets.all(size * 0.05),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
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
