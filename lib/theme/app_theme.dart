import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.teal,

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
    colorSchemeSeed: Colors.teal,

    scaffoldBackgroundColor: AppColors.darkBackground,

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
