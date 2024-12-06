import 'package:encaixado/presentation/pages/letter_boxed/helpers/path_controller.dart';
import 'package:flutter/material.dart';

class LetterBoxedButtons extends StatelessWidget {
  const LetterBoxedButtons({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });
  final PathController controller;
  final void Function() onSubmitted;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final btn = <Widget>[
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => controller.restartGame(),
        child: Text('Recomeçar'),
      ),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => controller.deleteLastLetter(),
        child: const Text('  Apagar  '),
      ),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => onSubmitted(),
        child: const Text('   Enviar   '),
      ),
    ];

    if (screenSize.width < 420) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: controller.boxSize * 0.8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: btn,
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: btn,
        ),
      );
    }
  }
}
