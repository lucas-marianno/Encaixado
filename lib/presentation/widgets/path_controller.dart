import 'package:flutter/material.dart';
import 'package:letter_boxed_engine/encaixado.dart';

class PathController {
  final Box box;
  final void Function() setStateCallback;
  PathController({required this.box, required this.setStateCallback});

  Offset? _touchStart;
  Offset? _touchEnd;
  Offset _localPosition = Offset.zero;
  final List<String> _path = [];
  late double _boxSize;
  late Offset _center;

  set boxSize(double size) {
    _boxSize = size;
    _center = Offset(_boxSize / 2, _boxSize / 2);

    setStateCallback();
  }

  set setPath(String path) {
    // TODO: add filtering to allow only box available letters

    _path.clear();
    _path.addAll(path.split(''));

    setStateCallback();
  }

  double get boxSize => _boxSize;
  Offset? get touchStart => _touchStart;
  Offset? get touchEnd => _touchEnd;
  Offset get center => _center;
  List<String> get path => _path;

  Map<String, Offset> get boxPositions {
    final longOffset = _boxSize * 0.45;
    final shortOffset = _boxSize * 0.27;

    final letters = box.letterBox.join();
    return {
      // top
      letters[0]: Offset(-shortOffset, -longOffset),
      letters[1]: Offset(0, -longOffset),
      letters[2]: Offset(shortOffset, -longOffset),
      // left
      letters[3]: Offset(-longOffset, -shortOffset),
      letters[4]: Offset(-longOffset, 0),
      letters[5]: Offset(-longOffset, shortOffset),
      // right
      letters[6]: Offset(longOffset, -shortOffset),
      letters[7]: Offset(longOffset, 0),
      letters[8]: Offset(longOffset, shortOffset),
      // bottom
      letters[9]: Offset(-shortOffset, longOffset),
      letters[10]: Offset(0, longOffset),
      letters[11]: Offset(shortOffset, longOffset),
    };
  }

  void onAcceptDrag(String initialLetter, String finalLetter) {
    // TODO: add filtering to block any adjacent letter connections
    // TODO: edit box in package to contain a bool function `isAdjacent`
    if (_path.isEmpty) _path.add(initialLetter);
    if (_path.isEmpty || _path.last != finalLetter) _path.add(finalLetter);

    _touchStart = boxPositions[finalLetter]! + _center;

    setStateCallback();
  }

  void onDragStart(String letter) {
    final start = _path.isNotEmpty ? _path.last : letter;
    _localPosition = boxPositions[letter]! + center;
    _touchStart ??= boxPositions[start]! + center;

    setStateCallback();
  }

  void onDragUpdate(DragUpdateDetails d) {
    _localPosition += d.delta;
    _touchEnd = _localPosition;

    setStateCallback();
  }

  void onDragEnd() {
    _touchStart = null;
    _touchEnd = null;
    _localPosition = Offset.zero;

    if (_path.length % 2 == 0 && _path.isNotEmpty) _path.removeLast;

    setStateCallback();
  }

  void deleteLastPath() {
    if (_path.isNotEmpty) _path.removeLast();
    _touchStart = _path.isNotEmpty ? boxPositions[_path.last] : null;

    setStateCallback();
  }

  void clearPath() {
    if (_path.isEmpty) return;

    _touchStart = null;
    _touchEnd = null;
    _localPosition = Offset.zero;
    _path.clear();

    setStateCallback();
  }
}
