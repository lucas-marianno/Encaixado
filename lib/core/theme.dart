import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: const Color.fromARGB(255, 0, 64, 68),
    onPrimary: Colors.grey[200]!,
    secondary: Colors.grey[800]!,
    onSecondary: Colors.grey[200]!,
    tertiary: Colors.grey[900]!,
    onTertiary: Colors.grey,
  ),
);
