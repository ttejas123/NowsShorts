import 'package:flutter/material.dart';
import 'app_colors.dart';

TextTheme buildTextTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final primary = isDark
      ? AppColors.darkTextPrimary
      : AppColors.lightTextPrimary;
  final secondary = isDark
      ? AppColors.darkTextSecondary
      : AppColors.lightTextSecondary;
  final hint = isDark ? AppColors.darkTextHint : AppColors.lightTextHint;

  return TextTheme(
    // Big titles (Yalla News, Select Regions, Settings)
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: primary,
    ),

    // Section titles (Category Filters, News on the go)
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: primary,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: primary,
    ),

    // Normal body text
    bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: secondary),

    // Small helper / subtitle text
    bodySmall: TextStyle(fontSize: 12, color: hint),

    // Labels (button text, card labels)
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: secondary,
    ),
  );
}
