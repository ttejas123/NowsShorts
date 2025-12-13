import 'package:bl_inshort/app/app.dart';
import 'package:bl_inshort/features/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  final themeController = ThemeController();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await themeController.loadTheme();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}