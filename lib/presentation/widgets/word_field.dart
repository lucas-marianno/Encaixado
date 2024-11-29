import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:encaixado/presentation/helpers/helpers.dart';

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
        if (value is! KeyDownEvent) return;
        final keyLabel = value.logicalKey.keyLabel.toLowerCase();

        if (controller.box.availableLetters.contains(keyLabel)) {
          controller.onAcceptDrag(keyLabel);
        }
        if (keyLabel == 'backspace') {
          controller.deleteLastLetter();
        }
        if (keyLabel == 'enter') {
          onSubmitted();
        }
      },
      child: GestureDetector(
        onTap: () {
          print('tap');
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
      ),
    );
  }
}
