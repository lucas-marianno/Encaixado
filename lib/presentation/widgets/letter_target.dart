import 'package:encaixado/domain/extensions/string_extension.dart';
import 'package:encaixado/presentation/game_controller.dart';
import 'package:encaixado/presentation/touch_controller.dart';
import 'package:flutter/material.dart';

class LetterTarget extends StatelessWidget {
  final String letter;
  final GameController gameController;
  final TouchController touchController;

  const LetterTarget(
    this.letter, {
    required this.gameController,
    required this.touchController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final path = gameController.word;
    final isSelected = letter.toLowerCase() == path.lastChar.toLowerCase();
    final isUsed =
        gameController.wordList.join().contains(letter.toLowerCase());

    return Transform.translate(
      offset:
          touchController.lettersPositioned[letter]! - touchController.center,
      child: DragTarget<String>(
        onAcceptWithDetails: (d) =>
            touchController.onAcceptDrag(d.data, letter),
        builder: (_, __, ___) {
          return Draggable<String>(
            data: letter,
            onDragStarted: () => touchController.onDragStart(letter),
            onDragUpdate: touchController.onDragUpdate,
            onDragEnd: (_) => touchController.onDragEnd(),
            feedback: const SizedBox(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: isSelected || !isUsed ? Colors.black : Colors.grey,
                  width: 2,
                ),
                boxShadow: !isSelected
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.pink,
                          spreadRadius: touchController.boxSize * 0.02,
                          blurRadius: touchController.boxSize * 0.02,
                        )
                      ],
              ),
              child: SizedBox(
                height: touchController.boxSize * .15,
                width: touchController.boxSize * .15,
                child: Center(
                  child: Text(
                    letter.toUpperCase(),
                    style: TextStyle(
                      color: isSelected || !isUsed ? Colors.black : Colors.grey,
                      fontWeight: isSelected ? FontWeight.w900 : null,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
