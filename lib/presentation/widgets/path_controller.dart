// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class PathController {
  PathController({required this.box, required this.setStateCallback});

  final Box box;
  final void Function() setStateCallback;
  final List<String> _letters = [];
  late double _boxSize;
  late Offset _center;
  Offset _touchPoint = Offset.zero;

  set boxSize(double size) {
    _boxSize = size;
    _center = Offset(_boxSize / 2, _boxSize / 2);

    setStateCallback();
  }

  set setLetters(String word) {
    if (word.contains(box.denied)) return;

    _letters.clear();
    _letters.addAll(word.split(''));

    setStateCallback();
  }

  double get boxSize => _boxSize;
  Offset? get touchStart =>
      _letters.isEmpty ? null : lettersPositioned[_letters.last]!;
  Offset get touchPoint => _touchPoint;
  Offset get center => _center;

  /// sequencial list of single character Strings in order of use (does not divide by word)
  List<String> get letters => _letters;

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
    if (_letters.isEmpty) _letters.add(initialLetter);
    if (_letters.isEmpty || _letters.last != finalLetter)
      _letters.add(finalLetter);
    if (_letters.join().contains(box.denied)) _letters.removeLast();

    setStateCallback();
  }

  void onDragStart(String letter) {
    if (_letters.isEmpty) _letters.add(letter);

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

  void deleteLastPath() {
    if (_letters.isEmpty) return;

    _letters.removeLast();

    setStateCallback();
  }

  void clearPath() {
    if (_letters.isEmpty) return;

    _touchPoint = Offset.zero;
    _letters.clear();

    setStateCallback();
  }

  /// TODO: implement
  ///
  /// check if word contains denied char sequences
  /// check if dictionary contains word
  ///
  /// if word is valid, add it to word sequence (uninplemented)
  /// else notify user
  void validate() {}
}
