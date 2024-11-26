import 'package:encaixado/presentation/path_controller.dart';
import 'package:flutter/material.dart';

class WordField extends StatelessWidget {
  const WordField({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  final PathController controller;
  final void Function() onSubmitted;

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
            enableInteractiveSelection: false,
            selectionControls: EmptyTextSelectionControls(),
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

                if (value.isEmpty) controller.deleteLastLetter();
              } else {
                // controller.setWord = value.toLowerCase();
                textController.selection =
                    TextSelection.collapsed(offset: value.length);
              }
            },
            onSubmitted: (_) {
              onSubmitted();
              focusNode.requestFocus();
            },
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(height: 10),
        // TODO: implement words used
        Text(controller.currentSolution.join('  ->  ')),
      ],
    );
  }
}
