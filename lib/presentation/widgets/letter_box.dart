import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final double size;
  const LetterBox(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final inset = size / 5;
    return SizedBox(
      height: size,
      width: size,
      child: Container(
          color: Colors.grey,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.center,
            children: [
              // top
              Positioned(top: -10, left: inset, child: const Text('A')),
              const Positioned(top: -10, child: Text('B')),
              Positioned(top: -10, right: inset, child: const Text('C')),
              // left
              Positioned(left: -5, top: inset, child: const Text('D')),
              const Positioned(left: -5, child: Text('E')),
              Positioned(left: -5, bottom: inset, child: const Text('F')),
              // right
              Positioned(right: -5, top: inset, child: const Text('G')),
              const Positioned(right: -5, child: Text('H')),
              Positioned(right: -5, bottom: inset, child: const Text('I')),
              // bottom
              Positioned(bottom: -10, left: inset, child: const Text('J')),
              const Positioned(bottom: -10, child: Text('K')),
              Positioned(bottom: -10, right: inset, child: const Text('L')),
            ],
          )),
    );
  }
}
