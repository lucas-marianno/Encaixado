import 'dart:math';

import 'package:flutter/material.dart';

import 'package:letter_boxed_engine/letter_boxed_engine.dart';

import 'package:encaixado/presentation/widgets/widgets.dart';
import 'package:encaixado/presentation/helpers/helpers.dart';

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
              '${controller.currentSolution.length} palavras:\n\n'
              '${controller.currentSolution.join(' - ').toUpperCase()}',
        );
      }
      setState(() {});
    } else {
      await dialog.show(
        message: '"${controller.currentWord}" não é uma palavra aceita',
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

    return Column(
      children: [
        Text('at least ${widget.game.nOfSolutions} solutions'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.1,
              vertical: screenSize.height * 0.1,
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
                  LetterBoxButtons(
                    controller: controller,
                    onSubmitted: () => submit(),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LetterBoxButtons extends StatelessWidget {
  const LetterBoxButtons({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });
  final PathController controller;
  final void Function() onSubmitted;

  @override
  Widget build(BuildContext context) {
    final btn = <Widget>[
      OutlinedButton(
        onPressed: () => controller.restartGame(),
        child: const Text('Recomeçar'),
      ),
      OutlinedButton(
        onPressed: () => controller.deleteLastLetter(),
        child: const Text('  Apagar  '),
      ),
      OutlinedButton(
        onPressed: () => onSubmitted(),
        child: const Text('   Enviar   '),
      ),
    ];

    final w = controller.boxSize * 2;

    if (w < 420) {
      return SizedBox(
        height: controller.boxSize * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: btn,
        ),
      );
    } else {
      return SizedBox(
        width: controller.boxSize * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: btn,
        ),
      );
    }
  }
}
