import 'package:flutter/material.dart';

class ColorsTheme {
  // Private constructor to prevent external instantiation
  ColorsTheme._();

  // Static instance of the class
  static final ColorsTheme _instance = ColorsTheme._();

  // Factory constructor to return the same instance
  factory ColorsTheme() => _instance;

  // Primary color and its shades
  final primaryColor = const Color.fromARGB(255, 46, 64, 125);
  final primaryLight = const Color.fromARGB(255, 72, 105, 161);
  final primaryDark = const Color.fromARGB(255, 36, 32, 94);

  // Accent color for highlights
  final accentColor = const Color.fromARGB(255, 129, 142, 199);

  // Neutral colors
  final whiteColor = Colors.white;
  final backgroundColor = const Color.fromARGB(255, 245, 245, 245);
  final cardColor = Colors.white;

  // Error color
  final errorColor = Colors.red;
}
