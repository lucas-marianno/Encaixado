import 'package:flutter/material.dart';

class PreviousGameButton extends StatelessWidget {
  const PreviousGameButton(
      {required this.gameLabel, required this.onTap, super.key});

  final String gameLabel;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: TextButton(
          onPressed: () => onTap(),
          child: Text(
            gameLabel,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
