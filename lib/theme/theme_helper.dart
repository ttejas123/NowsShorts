import 'package:flutter/material.dart';

enum AppThemeMode {
  system,
  light,
  dark,
}

ThemeMode toThemeMode(AppThemeMode mode) {
  switch (mode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

const themeKey = 'app_theme_mode';