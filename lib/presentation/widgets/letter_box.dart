import 'package:encaixado/presentation/widgets/custom_painter.dart';
import 'package:flutter/material.dart';

class LetterBox extends StatefulWidget {
  final double size;
  const LetterBox(this.size, {super.key});

  @override
  State<LetterBox> createState() => _LetterBoxState();
}

class _LetterBoxState extends State<LetterBox> {
  Offset? startPos;
  Offset? touchPos;
  List<List<Offset>> path = [];

  @override
  Widget build(BuildContext context) {
    final center = Offset(widget.size * 0.485, widget.size * 0.46);
    final longOffset = widget.size * 0.45;
    final shortOffset = widget.size * 0.27;

    final Map<String, Offset> letterBoxPos = {
      // top
      'A': Offset(-shortOffset, -longOffset),
      'B': Offset(0, -longOffset),
      'C': Offset(shortOffset, -longOffset),
      // left
      'D': Offset(-longOffset, -shortOffset),
      'E': Offset(-longOffset, 0),
      'F': Offset(-longOffset, shortOffset),
      // right
      'G': Offset(longOffset, -shortOffset),
      'H': Offset(longOffset, 0),
      'I': Offset(longOffset, shortOffset),
      // bottom
      'J': Offset(-shortOffset, longOffset),
      'K': Offset(0, longOffset),
      'L': Offset(shortOffset, longOffset),
    };
    // onPanStart: (_) =>
    //     setState(() => startPos ??= entry.value + center),
    // onPanUpdate: (d) => setState(() =>
    //     touchPos = d.localPosition + entry.value + center),
    // onPanEnd: (d) => setState(() {
    //   final end = d.localPosition + entry.value + center;
    //   print('end: $end | G: ${letterBoxPos['G']! + center}');

    //   path.add([startPos!, end]);
    //   startPos = end;
    //   touchPos = null;
    // }),
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        foregroundPainter: LinePainer(startPos, touchPos, path: path),
        child: Container(
          color: Colors.grey,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              for (var entry in letterBoxPos.entries)
                Transform.translate(
                  offset: entry.value,
                  child: DragTarget<Offset>(
                    onAcceptWithDetails: (d) {
                      // TODO: create logic to prevent adjacent connections
                      setState(() {
                        final end = entry.value + center;
                        path.add([d.data, end]);
                        startPos = end;
                        touchPos = null;
                      });
                    },
                    builder: (_, __, ___) {
                      Offset? initialGlobal;
                      return Draggable<Offset>(
                        data: entry.value + center,
                        onDragStarted: () {
                          startPos = entry.value + center;
                        },
                        onDragUpdate: (d) {
                          setState(() {
                            initialGlobal ??= d.globalPosition;
                            touchPos = d.globalPosition - initialGlobal!;
                          });
                        },
                        feedback: const Material(
                          color: Colors.transparent,
                          child: Text('X'),
                        ),
                        child: Text(entry.key),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
