import 'package:encaixado/presentation/widgets/letter_target.dart';
import 'package:encaixado/presentation/widgets/path_controller.dart';
import 'package:encaixado/presentation/widgets/path_painter.dart';
import 'package:flutter/material.dart';

class LetterBox extends StatefulWidget {
  final double size;
  const LetterBox(this.size, {super.key});

  @override
  State<LetterBox> createState() => _LetterBoxState();
}

class _LetterBoxState extends State<LetterBox> {
  late final PathController controller;

  @override
  void initState() {
    super.initState();

    controller = PathController(setStateCallback: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
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

    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        foregroundPainter: PathPainter(controller),
        child: Container(
          color: Colors.grey,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              for (var entry in letterBoxPos.entries)
                LetterTarget(
                  label: entry.key,
                  letterOffsetFromCenter: entry.value,
                  center: Offset(widget.size / 2, widget.size / 2),
                  controller: controller,
                )
            ],
          ),
        ),
      ),
    );
  }
}
