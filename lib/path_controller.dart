// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:encaixado/domain/extensions/string_buffer_extentsion.dart';
import 'package:encaixado/domain/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class PathController {
  final Box box;
  final void Function() setStateCallback;
  final LetterBoxedEngine engine;
  final BuildContext context;
  PathController({
    required this.context,
    required this.engine,
    required this.box,
    required this.setStateCallback,
  });

  final StringBuffer _wordBuffer = StringBuffer();
  final List<String> _wordList = [];
  late double _boxSize;
  late Offset _center;
  Offset _touchPoint = Offset.zero;

  set boxSize(double size) {
    _boxSize = size;
    _center = Offset(_boxSize / 2, _boxSize / 2);

    setStateCallback();
  }

  set setWord(String word) {
    if (word.contains(box.denied)) return;

    _wordBuffer.clear();
    _wordBuffer.write(word);

    setStateCallback();
  }

  double get boxSize => _boxSize;
  Offset? get touchStart =>
      _wordBuffer.isEmpty ? null : lettersPositioned[_wordBuffer.lastChar]!;
  Offset get touchPoint => _touchPoint;
  Offset get center => _center;
  String get currentWord => _wordBuffer.toString();
  List<String> get wordList => _wordList;

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
    if (_wordBuffer.isEmpty) _wordBuffer.write(initialLetter);
    if (_wordBuffer.isEmpty || _wordBuffer.lastChar != finalLetter)
      _wordBuffer.write(finalLetter);
    if (_wordBuffer.toString().contains(box.denied)) _wordBuffer.removeLast();

    setStateCallback();
  }

  void onDragStart(String letter) {
    if (_wordBuffer.isEmpty) _wordBuffer.write(letter);

    _touchPoint = lettersPositioned[letter]!;

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

  void deleteLastChar() {
    if (_wordList.isEmpty) {
      if (_wordBuffer.isEmpty) return;
      _wordBuffer.removeLast();
    } else {
      if (_wordBuffer.length > 1) {
        _wordBuffer.removeLast();
      } else {
        _wordBuffer.clear();
        _wordBuffer.write(_wordList.last);
        _wordList.removeLast();
      }
    }

    setStateCallback();
  }

  void restartGame() {
    _touchPoint = Offset.zero;
    _wordBuffer.clear();
    _wordList.clear();

    setStateCallback();
  }

  /// check if word contains denied char sequences
  /// check if dictionary contains word
  ///
  /// if word is valid, add it to word sequence (uninplemented)
  Future<void> validate() async {
    if (engine.validateWord(currentWord, box)) {
      final startingLetter = currentWord.lastChar;
      _wordList.add(currentWord);
      _wordBuffer.clear();
      _wordBuffer.write(startingLetter);

      if (engine.validateSolution(_wordList, box)) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Genial!'),
            content: Text(
              'Você resolveu o Encaixado de hoje com apenas '
              '${_wordList.length} palavras:\n\n$_wordList',
            ),
          ),
        );
      }
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('"$currentWord" não é uma palavra aceita'),
        ),
      );
    }

    setStateCallback();
  }
}
