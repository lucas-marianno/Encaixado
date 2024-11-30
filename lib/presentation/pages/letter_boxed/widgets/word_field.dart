import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:encaixado/presentation/pages/letter_boxed/helpers/helpers.dart';

class WordField extends StatelessWidget {
  WordField({required this.controller, required this.onSubmitted, super.key});
  final PathController controller;
  final void Function() onSubmitted;

  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (value) {
        if (value is KeyUpEvent) return;

        final keyLabel = value.logicalKey.keyLabel.toLowerCase();

        if (keyLabel == 'backspace') controller.deleteLastLetter();
        if (value is! KeyDownEvent) return;
        if (keyLabel == 'enter') onSubmitted();
        if (controller.box.availableLetters.contains(keyLabel)) {
          controller.onAcceptDrag(keyLabel);
        }
      },
      child: Container(
        color: Colors.transparent,
        width: controller.boxSize * 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(controller.currentWord.toUpperCase()),
            const Divider(height: 10, indent: 10, endIndent: 10),
            Text(controller.currentSolution.join('  ->  ').toUpperCase()),
          ],
        ),
      ),
    );
  }
}
