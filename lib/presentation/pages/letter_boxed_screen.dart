import 'dart:math';

import 'package:encaixado/presentation/widgets/letter_box.dart';
import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:flutter/material.dart';

class LetterBoxedScreen extends StatefulWidget {
  const LetterBoxedScreen({super.key});

  @override
  State<LetterBoxedScreen> createState() => _LetterBoxedScreenState();
}

class _LetterBoxedScreenState extends State<LetterBoxedScreen> {
  late final PathController controller;

  @override
  void initState() {
    super.initState();
    controller = PathController(setStateCallback: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.1,
        vertical: screenSize.height * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: min(screenSize.width * 0.6, screenSize.height * 0.3),
            child: const TextField(),
          ),
          LetterBox(
            min(screenSize.width * 0.5, screenSize.height * 0.3),
            controller: controller,
          ),
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
                onPressed: () {
                  // TODO: implement
                },
                child: const Text('Enter'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
