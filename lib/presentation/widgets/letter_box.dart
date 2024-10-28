import 'package:encaixado/presentation/widgets/custom_painter.dart';
import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final double size;
  const LetterBox(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final inset = size / 5;
    final margin = inset / 4;
    return SizedBox(
      height: size,
      width: size,
      child: TouchCanvas(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            // top
            Positioned(top: margin, left: inset, child: const Text('A')),
            Positioned(top: margin, child: const Text('B')),
            Positioned(top: margin, right: inset, child: const Text('C')),
            // left
            Positioned(left: margin, top: inset, child: const Text('D')),
            Positioned(left: margin, child: const Text('E')),
            Positioned(left: margin, bottom: inset, child: const Text('F')),
            // right
            Positioned(right: margin, top: inset, child: const Text('G')),
            Positioned(right: margin, child: const Text('H')),
            Positioned(right: margin, bottom: inset, child: const Text('I')),
            // bottom
            Positioned(bottom: margin, left: inset, child: const Text('J')),
            Positioned(bottom: margin, child: const Text('K')),
            Positioned(bottom: margin, right: inset, child: const Text('L')),
          ],
        ),
      ),
    );
  }
}

class TouchCanvas extends StatefulWidget {
  const TouchCanvas({required this.child, super.key});
  final Widget child;

  @override
  State<TouchCanvas> createState() => _TouchCanvasState();
}

class _TouchCanvasState extends State<TouchCanvas> {
  Offset? start;
  Offset? touch;
  Offset? end;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (d) => setState(() => start = d.localPosition),
      onPanUpdate: (d) => setState(() => touch = d.localPosition),
      onPanEnd: (d) => setState(() => end = d.localPosition),
      child: CustomPaint(
        foregroundPainter: LinePainer(start, touch, end),
        child: Container(color: Colors.grey, child: widget.child),
      ),
    );
  }
}
