import 'dart:math';

import 'package:encaixado/presentation/widgets/letter_box.dart';
import 'package:flutter/material.dart';

class LetterBoxedScreen extends StatelessWidget {
  const LetterBoxedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1,
          vertical: screenSize.height * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: min(screenSize.width * 0.6, screenSize.height * 0.3),
              child: const TextField()),
          LetterBox(min(screenSize.width * 0.5, screenSize.height * 0.3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('data')),
              OutlinedButton(onPressed: () {}, child: const Text('data')),
              OutlinedButton(onPressed: () {}, child: const Text('data')),
            ],
          )
        ],
      ),
    );
  }
}
