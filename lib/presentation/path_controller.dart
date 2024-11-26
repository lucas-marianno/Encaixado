import 'package:encaixado/domain/extensions/string_buffer_extentsion.dart';
import 'package:encaixado/domain/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class PathController {
  final Box box;
  final void Function() setStateCallback;

  PathController({
    required this.box,
    required this.setStateCallback,
  });

  set boxSize(double size) {
    _boxSize = size;
    _center = Offset(_boxSize / 2, _boxSize / 2);

    setStateCallback();
  }

  double get boxSize => _boxSize;
  Offset? get touchStart =>
      _wordBuffer.isEmpty ? null : letterPosition(_wordBuffer.lastChar);
  Offset get touchPoint => _touchPoint;
  String get currentWord => _wordBuffer.toString();
  List<String> get currentSolution => _wordList;

  Offset letterPositionAbsolute(String letter) {
    assert(letter.length == 1 && box.availableLetters.contains(letter));
    return _letterPositions[letter]!;
  }

  Offset letterPosition(String letter) {
    return letterPositionAbsolute(letter) + _center;
  }

  void onAcceptDrag(String finalLetter) {
    assert(finalLetter.length == 1);
    if ('$_wordBuffer$finalLetter'.contains(box.denied)) return;

    _wordBuffer.write(finalLetter);

    setStateCallback();
  }

  void onDragStart(String letter) {
    assert(letter.length == 1);
    if (_wordBuffer.isEmpty) _wordBuffer.write(letter);

    _touchPoint = letterPosition(letter);

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

  void deleteLastLetter() {
    if (_wordBuffer.isEmpty & _wordList.isEmpty) return;

    if (_wordBuffer.isNotEmpty) _wordBuffer.removeLast();

    if (_wordBuffer.isEmpty && _wordList.isNotEmpty) {
      _wordBuffer.write(_wordList.last);
      _wordList.removeLast();
    }

    setStateCallback();
  }

  void restartGame() {
    _touchPoint = Offset.zero;
    _wordBuffer.clear();
    _wordList.clear();

    setStateCallback();
  }

  void addCurrentWordToSolution() {
    final startingLetter = currentWord.lastChar;

    _wordList.add(currentWord);
    _wordBuffer.clear();
    _wordBuffer.write(startingLetter);

    setStateCallback();
  }

  final StringBuffer _wordBuffer = StringBuffer();
  final List<String> _wordList = [];
  late double _boxSize;
  late Offset _center;
  Offset _touchPoint = Offset.zero;

  Map<String, Offset> get _letterPositions {
    final longOffset = _boxSize * 0.45;
    final shortOffset = _boxSize * 0.27;

    final boxLetters = box.letterBox.join();
    return {
      // top
      boxLetters[0]: Offset(-shortOffset, -longOffset),
      boxLetters[1]: Offset(0, -longOffset),
      boxLetters[2]: Offset(shortOffset, -longOffset),
      // left
      boxLetters[3]: Offset(-longOffset, -shortOffset),
      boxLetters[4]: Offset(-longOffset, 0),
      boxLetters[5]: Offset(-longOffset, shortOffset),
      // right
      boxLetters[6]: Offset(longOffset, -shortOffset),
      boxLetters[7]: Offset(longOffset, 0),
      boxLetters[8]: Offset(longOffset, shortOffset),
      // bottom
      boxLetters[9]: Offset(-shortOffset, longOffset),
      boxLetters[10]: Offset(0, longOffset),
      boxLetters[11]: Offset(shortOffset, longOffset),
    };
  }
}
