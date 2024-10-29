import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class LetterTarget extends StatelessWidget {
  final String label;
  final Offset letterOffsetFromCenter;
  final Offset center;

  final PathController controller;

  const LetterTarget({
    required this.letterOffsetFromCenter,
    required this.label,
    required this.controller,
    required this.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: letterOffsetFromCenter,
      child: DragTarget<Offset>(
        onAcceptWithDetails: (d) {
          controller.onAcceptDrag(d, letterOffsetFromCenter, center);
        },
        builder: (_, __, ___) {
          return Draggable<Offset>(
            data: controller.startPos ?? letterOffsetFromCenter + center,
            onDragStarted: () {
              controller.onDragStart(letterOffsetFromCenter, center);
            },
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
              child: Text(label),
            ),
          );
        },
      ),
    );
  }
}
