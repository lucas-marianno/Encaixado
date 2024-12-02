import 'dart:math';

import 'package:encaixado/presentation/widgets/dialog.dart';
import 'package:flutter/material.dart';

import 'package:letter_boxed_engine/letter_boxed_engine.dart';

import 'package:encaixado/presentation/pages/letter_boxed/widgets/letter_boxed_widgets.dart';
import 'package:encaixado/presentation/pages/letter_boxed/helpers/helpers.dart';

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

      final solution = controller.currentSolution;
      final isValidSolution =
          widget.gameEngine.validateSolution(solution, widget.game.box);
      if (isValidSolution) {
        await dialog.show(
            title: 'Genial!',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Você resolveu o Encaixado de hoje com apenas '
                    '${solution.length}'
                    ' palavra${solution.length > 1 ? 's' : ''}:'),
                const Text('\n\n'),
                Text(solution.join(' - ').toUpperCase()),
              ],
            ));
      }
      setState(() {});
    } else {
      await dialog.show(
        content: Text('"${controller.currentWord}" não é uma palavra aceita'),
      );
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
    controller.updateBox = widget.game.box;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
        vertical: screenSize.height * 0.02,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            WordField(
              controller: controller,
              onSubmitted: () => submit(),
            ),
            LetterBox(controller: controller),
            LetterBoxedButtons(
              controller: controller,
              onSubmitted: () => submit(),
            )
          ],
        ),
      ),
    );
  }
}
