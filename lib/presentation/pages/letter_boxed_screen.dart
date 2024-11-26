import 'dart:math';

import 'package:encaixado/presentation/widgets/dialog.dart';
import 'package:encaixado/presentation/widgets/letter_box.dart';
import 'package:encaixado/presentation/path_controller.dart';
import 'package:encaixado/presentation/widgets/word_field.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class LetterBoxedScreen extends StatefulWidget {
  final LetterBoxedEngine gameEngine;
  final Game game;

  const LetterBoxedScreen({
    required this.gameEngine,
    required this.game,
    super.key,
  });

  @override
  State<LetterBoxedScreen> createState() => _LetterBoxedScreenState();
}

class _LetterBoxedScreenState extends State<LetterBoxedScreen> {
  late final PathController controller;
  late final MessageDialog dialog;

  void submit() async {
    final isValidWord =
        widget.gameEngine.validateWord(controller.currentWord, widget.game.box);

    if (isValidWord) {
      controller.addCurrentWordToSolution();

      final isValidSolution = widget.gameEngine
          .validateSolution(controller.currentSolution, widget.game.box);
      if (isValidSolution) {
        await dialog.show(
          title: 'Genial!',
          message: 'Você resolveu o Encaixado de hoje com apenas '
              '${controller.currentSolution.length} palavras:'
              '\n\n${controller.currentSolution}',
        );
      }
    } else {
      dialog.show(
          message: '"${controller.currentWord}" não é uma palavra aceita');
    }
  }

  @override
  void initState() {
    super.initState();
    dialog = MessageDialog(context);
    controller = PathController(
      box: widget.game.box,
      setStateCallback: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    controller.boxSize = min(screenSize.width * 0.5, screenSize.height * 0.3);
    return Column(
      children: [
        Text('at least ${widget.game.nOfSolutions} solutions'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.1,
              vertical: screenSize.height * 0.1,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordField(controller: controller, onSubmitted: () => submit()),
                LetterBox(controller: controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => controller.restartGame(),
                      child: const Text('Restart'),
                    ),
                    OutlinedButton(
                      onPressed: () => controller.deleteLastLetter(),
                      child: const Text('Delete'),
                    ),
                    OutlinedButton(
                      onPressed: () => submit(),
                      child: const Text('Enter'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
