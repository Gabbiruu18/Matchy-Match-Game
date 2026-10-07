import 'package:flutter/material.dart';

// Equivalent of Color.kt
const Color purple80 = Color(0xFFD0BCFF);
const Color purpleGrey80 = Color(0xFFCCC2DC);
const Color pink80 = Color(0xFFEFB8C8);

const Color purple40 = Color(0xFF6650A4);
const Color purpleGrey40 = Color(0xFF625B71);
const Color pink40 = Color(0xFF7D5260);

// Equivalent of Theme.kt + Type.kt
ThemeData matchingGameTheme({required bool dark}) {
  final colorScheme = dark
      ? const ColorScheme.dark(
    primary: purple80,
    secondary: purpleGrey80,
    tertiary: pink80,
  )
      : const ColorScheme.light(
    primary: purple40,
    secondary: purpleGrey40,
    tertiary: pink40,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        height: 24 / 16, // lineHeight expressed as a multiplier of fontSize
        letterSpacing: 0.5,
      ),
    ),
  );
}
