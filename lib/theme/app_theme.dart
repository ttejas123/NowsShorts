import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // colorSchemeSeed: Colors.teal,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(255, 100, 214, 255),
      onSecondary: Colors.black,

      background: AppColors.lightBackground,
      onBackground: AppColors.lightTextPrimary,

      surface: AppColors.lightCard,
      onSurface: AppColors.lightTextPrimary,

      error: Colors.red,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: AppColors.lightBackground,

    textTheme: buildTextTheme(Brightness.light),

    cardTheme: const CardThemeData(
      color: AppColors.lightCard,
      elevation: 1,
      margin: EdgeInsets.zero,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.lightDivider,
      thickness: 0.6,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // colorSchemeSeed: Colors.teal,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.blue,
      onPrimary: Colors.black,
      secondary: const Color.fromARGB(255, 100, 224, 255),
      onSecondary: Colors.black,

      background: AppColors.darkBackground,
      onBackground: AppColors.darkTextPrimary,

      surface: AppColors.darkCard,
      onSurface: AppColors.darkTextPrimary,

      error: Colors.red,
      onError: Colors.black,
    ),

    textTheme: buildTextTheme(Brightness.dark),

    cardTheme: const CardThemeData(
      color: AppColors.darkCard,
      elevation: 1,
      margin: EdgeInsets.zero,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 0.6,
    ),
  );
}
