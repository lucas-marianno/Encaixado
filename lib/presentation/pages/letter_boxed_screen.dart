import 'dart:math';

import 'package:encaixado/presentation/widgets/letter_box.dart';
import 'package:encaixado/path_controller.dart';
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

  @override
  void initState() {
    super.initState();
    controller = PathController(
      context: context,
      engine: widget.gameEngine,
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
                WordField(controller: controller),
                LetterBox(controller: controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => controller.restartGame(),
                      child: const Text('Reiniciar'),
                    ),
                    OutlinedButton(
                      onPressed: () => controller.deleteLastChar(),
                      child: const Text('  Apagar  '),
                    ),
                    OutlinedButton(
                      onPressed: () => controller.validate(),
                      child: const Text('    Ir    '),
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
