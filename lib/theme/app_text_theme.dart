import 'package:flutter/material.dart';

TextTheme buildTextTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  return TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white : Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: isDark ? Colors.white70 : Colors.black54,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: isDark ? Colors.white60 : Colors.black45,
    ),
  );
}
