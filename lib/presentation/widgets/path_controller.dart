import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class PathController {
  PathController({required this.box, required this.setStateCallback});
  final Box box;
  final void Function() setStateCallback;
  final List<String> _path = [];
  late double _boxSize;
  late Offset _center;
  Offset _touchPoint = Offset.zero;

  set boxSize(double size) {
    _boxSize = size;
    _center = Offset(_boxSize / 2, _boxSize / 2);

    setStateCallback();
  }

  set setPath(String path) {
    if (path.contains(box.denied)) return;

    _path.clear();
    _path.addAll(path.split(''));

    setStateCallback();
  }

  double get boxSize => _boxSize;
  Offset? get touchStart => path.isEmpty ? null : lettersPositioned[path.last]!;
  Offset get touchPoint => _touchPoint;
  Offset get center => _center;
  List<String> get path => _path;

  Map<String, Offset> get lettersPositioned {
    final longOffset = _boxSize * 0.45;
    final shortOffset = _boxSize * 0.27;

    final letters = box.letterBox.join();
    return {
      // top
      letters[0]: Offset(-shortOffset, -longOffset) + _center,
      letters[1]: Offset(0, -longOffset) + _center,
      letters[2]: Offset(shortOffset, -longOffset) + _center,
      // left
      letters[3]: Offset(-longOffset, -shortOffset) + _center,
      letters[4]: Offset(-longOffset, 0) + _center,
      letters[5]: Offset(-longOffset, shortOffset) + _center,
      // right
      letters[6]: Offset(longOffset, -shortOffset) + _center,
      letters[7]: Offset(longOffset, 0) + _center,
      letters[8]: Offset(longOffset, shortOffset) + _center,
      // bottom
      letters[9]: Offset(-shortOffset, longOffset) + _center,
      letters[10]: Offset(0, longOffset) + _center,
      letters[11]: Offset(shortOffset, longOffset) + _center,
    };
  }

  void onAcceptDrag(String initialLetter, String finalLetter) {
    if (_path.isEmpty) _path.add(initialLetter);
    if (_path.isEmpty || _path.last != finalLetter) _path.add(finalLetter);
    if (_path.join().contains(box.denied)) _path.removeLast();

    setStateCallback();
  }

  void onDragStart(String letter) {
    if (path.isEmpty) path.add(letter);

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
    if (_path.isEmpty) return;

    _path.removeLast();

    setStateCallback();
  }

  void clearPath() {
    if (_path.isEmpty) return;

    _touchPoint = Offset.zero;
    _path.clear();

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
