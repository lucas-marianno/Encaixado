// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:encaixado/presentation/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class TouchController {
  final Box box;
  final void Function() setStateCallback;
  final LetterBoxedEngine engine;
  final GameController gameController;

  TouchController({
    required this.gameController,
    required this.engine,
    required this.box,
    required this.setStateCallback,
  });

  late double _boxSize;
  late Offset _center;
  Offset? _touchStart;
  Offset _touchPoint = Offset.zero;

  set boxSize(double size) {
    _boxSize = size;
    _center = Offset(_boxSize / 2, _boxSize / 2);

    setStateCallback();
  }

  double get boxSize => _boxSize;
  Offset? get touchStart => _touchStart;

  Offset get touchPoint => _touchPoint;
  Offset get center => _center;
  // String get currentWord => gameController.word.toString();
  // List<String> get wordList => gameController.wordList;

  Map<String, Offset> get lettersPositioned {
    final longOffset = _boxSize * 0.45;
    final shortOffset = _boxSize * 0.27;

    final boxLetters = box.letterBox.join();
    return {
      // top
      boxLetters[0]: Offset(-shortOffset, -longOffset) + _center,
      boxLetters[1]: Offset(0, -longOffset) + _center,
      boxLetters[2]: Offset(shortOffset, -longOffset) + _center,
      // left
      boxLetters[3]: Offset(-longOffset, -shortOffset) + _center,
      boxLetters[4]: Offset(-longOffset, 0) + _center,
      boxLetters[5]: Offset(-longOffset, shortOffset) + _center,
      // right
      boxLetters[6]: Offset(longOffset, -shortOffset) + _center,
      boxLetters[7]: Offset(longOffset, 0) + _center,
      boxLetters[8]: Offset(longOffset, shortOffset) + _center,
      // bottom
      boxLetters[9]: Offset(-shortOffset, longOffset) + _center,
      boxLetters[10]: Offset(0, longOffset) + _center,
      boxLetters[11]: Offset(shortOffset, longOffset) + _center,
    };
  }

  void onAcceptDrag(String initialLetter, String finalLetter) {
    if (gameController.word.isEmpty) gameController.addChar(initialLetter);
    gameController.addChar(finalLetter);

    setStateCallback();
  }

  void onDragStart(String letter) {
    if (gameController.word.isEmpty) gameController.addChar(letter);
    _touchStart = lettersPositioned[letter]!;
    _touchPoint = _touchStart!;

    setStateCallback();
  }

  void onDragUpdate(DragUpdateDetails d) {
    _touchPoint += d.delta;

    setStateCallback();
  }

  void onDragEnd() {
    _touchPoint = Offset.zero;

    setStateCallback();
  }
}
