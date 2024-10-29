import 'package:flutter/material.dart';

class PathController {
  final void Function() setStateCallback;

  Offset? _startPos;
  Offset? _touchPos;
  Offset _localPos = Offset.zero;
  final List<List<Offset>> _path = [];

  PathController({required this.setStateCallback});

  Offset? get startPos => _startPos;
  Offset? get touchPos => _touchPos;
  Offset get localPos => _localPos;
  List<List<Offset>> get path => _path;

  void onAcceptDrag(
      DragTargetDetails<Offset> d, Offset entryOffset, Offset center) {
    final end = entryOffset + center;
    _path.add([d.data, end]);
    _startPos = end;
    setStateCallback();
  }

  void onDragStart(Offset entryOffset, Offset center) {
    _startPos ??= entryOffset + center;
    _localPos = entryOffset + center;
    setStateCallback();
  }

  void onDragUpdate(DragUpdateDetails d) {
    _localPos += d.delta;
    _touchPos = _localPos;
    setStateCallback();
  }

  void onDragEnd() {
    _touchPos = null;
    _localPos = Offset.zero;
    setStateCallback();
  }
}
