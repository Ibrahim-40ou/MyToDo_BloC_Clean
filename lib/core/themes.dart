import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF5F4FB),
    primary: Color(0xFF332AD5),
    onPrimary: Colors.white,
    onSurface: Color(0xFF06060E),
    secondary: Color(0xFF918EF1),
    onSecondary: Colors.white,
    error: Color(0xFFFF0000),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Color(0xFF06060E),
    ),
    labelMedium: TextStyle(
      color: Color(0xFF717171),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF332AD5), // Button text color
    ),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF05040B),
    primary: Color(0xFF332AD5),
    onPrimary: Colors.white,
    onSurface: Color(0xFFF1F1F9),
    secondary: Color(0xFF110E71),
    onSecondary: Colors.white,
    error: Color(0xFFDB0000),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Color(0xFFF1F1F9),
    ),
    labelMedium: TextStyle(
      color: Color(0xFF717171),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF332AD5), // Button text color
    ),
  ),
);
