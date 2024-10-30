import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class LetterTarget extends StatelessWidget {
  final String letter;
  final Offset letterOffsetFromCenter;
  final Offset center;

  final PathController controller;

  const LetterTarget({
    required this.letterOffsetFromCenter,
    required this.letter,
    required this.controller,
    required this.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: letterOffsetFromCenter,
      child: DragTarget<String>(
        onAcceptWithDetails: (d) => controller.onAcceptDrag(d.data, letter),
        builder: (_, __, ___) {
          return Draggable<String>(
            data: letter,
            onDragStarted: () => controller.onDragStart(letter),
            onDragUpdate: controller.onDragUpdate,
            onDragEnd: (_) => controller.onDragEnd(),
            feedback: const SizedBox(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(letter.toUpperCase()),
            ),
          );
        },
      ),
    );
  }
}
