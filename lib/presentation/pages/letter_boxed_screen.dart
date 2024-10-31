import 'dart:math';

import 'package:encaixado/presentation/widgets/letter_box.dart';
import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:encaixado/presentation/widgets/word_field.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/encaixado.dart';

class LetterBoxedScreen extends StatefulWidget {
  const LetterBoxedScreen({super.key});

  @override
  State<LetterBoxedScreen> createState() => _LetterBoxedScreenState();
}

class _LetterBoxedScreenState extends State<LetterBoxedScreen> {
  late final PathController controller;
  final box = Box.fromString('abc def ghi jkl');

  @override
  void initState() {
    super.initState();
    controller = PathController(
      box: box,
      setStateCallback: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    controller.boxSize = min(screenSize.width * 0.5, screenSize.height * 0.3);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.1,
        vertical: screenSize.height * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WordField(controller: controller),
          LetterBox(controller: controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () => controller.clearPath(),
                child: const Text('Restart'),
              ),
              OutlinedButton(
                onPressed: () => controller.deleteLastPath(),
                child: const Text('Delete'),
              ),
              OutlinedButton(
                onPressed: () => controller.validate(),
                child: const Text('Enter'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
