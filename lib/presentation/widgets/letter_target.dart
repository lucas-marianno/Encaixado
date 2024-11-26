import 'package:encaixado/domain/extensions/string_extension.dart';
import 'package:encaixado/presentation/path_controller.dart';
import 'package:flutter/material.dart';

class LetterTarget extends StatelessWidget {
  final String letter;
  final PathController controller;

  const LetterTarget(this.letter, {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final path = controller.currentWord;
    final isSelected = letter.toLowerCase() == path.lastChar.toLowerCase();
    final isUsed =
        controller.currentSolution.join().contains(letter.toLowerCase());

    return Transform.translate(
      offset: controller.letterPositionAbsolute(letter),
      child: DragTarget<String>(
        onAcceptWithDetails: (_) => controller.onAcceptDrag(letter),
        builder: (_, __, ___) {
          return Draggable<String>(
            data: letter,
            onDragStarted: () => controller.onDragStart(letter),
            onDragUpdate: controller.onDragUpdate,
            onDragEnd: (_) => controller.onDragEnd(),
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
                          spreadRadius: controller.boxSize * 0.02,
                          blurRadius: controller.boxSize * 0.02,
                        )
                      ],
              ),
              child: SizedBox(
                height: controller.boxSize * .15,
                width: controller.boxSize * .15,
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
