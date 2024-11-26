import 'package:encaixado/path_controller.dart';
import 'package:flutter/material.dart';

class WordField extends StatelessWidget {
  const WordField({required this.controller, super.key});

  final PathController controller;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final textController = TextEditingController();
    final text = controller.currentWord.toUpperCase();
    textController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );

    return Column(
      children: [
        SizedBox(
          width: controller.boxSize,
          child: TextField(
            controller: textController,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            showCursor: true,
            onChanged: (value) {
              if (value.isEmpty || value.contains(controller.box.denied)) {
                textController.value = TextEditingValue(
                  text: controller.currentWord.toUpperCase(),
                  selection: TextSelection.collapsed(
                    offset: controller.currentWord.length,
                  ),
                );

                if (value.isEmpty) controller.deleteLastChar();
              } else {
                controller.setWord = value.toLowerCase();
                textController.selection =
                    TextSelection.collapsed(offset: value.length);
              }
            },
            onSubmitted: (_) {
              controller.validate();
              focusNode.requestFocus();
            },
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 10),
        // TODO: implement words used
        Text(controller.wordList.join('  ->  ')),
      ],
    );
  }
}
