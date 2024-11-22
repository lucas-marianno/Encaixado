import 'package:encaixado/presentation/game_controller.dart';
import 'package:encaixado/presentation/widgets/letter_target.dart';
import 'package:encaixado/presentation/touch_controller.dart';
import 'package:encaixado/presentation/widgets/path_painter.dart';
import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final TouchController touchController;
  final GameController gameController;
  const LetterBox(
      {required this.touchController, required this.gameController, super.key});

  @override
  Widget build(BuildContext context) {
    final letterBoxPos = touchController.lettersPositioned;
    final size = touchController.boxSize;

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CustomPaint(
            foregroundPainter: PathPainter(
              touchController: touchController,
              gameController: gameController,
            ),
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
              entry.key,
              gameController: gameController,
              touchController: touchController,
            ),
        ],
      ),
    );
  }
}
