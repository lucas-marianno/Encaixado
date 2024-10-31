import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class WordField extends StatelessWidget {
  const WordField({required this.controller, super.key});

  final PathController controller;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final text = controller.path.join().toUpperCase();
    textController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );

    return Column(
      children: [
        SizedBox(
          width: controller.boxSize,
          child: TextField(
            textAlign: TextAlign.center,
            showCursor: true,
            onChanged: (value) {
              if (value.contains(controller.box.denied())) {
                value = value.substring(0, value.length - 1);
              }
              controller.setPath = value.toLowerCase();
            },
            keyboardType: TextInputType.text,
            controller: textController,
          ),
        ),
        const SizedBox(height: 10),
        // TODO: implement words used
        const Text('WORD1  ->  WORD2  ->  WORD3'),
      ],
    );
  }
}
