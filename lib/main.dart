import 'package:bl_inshort/app/app.dart';
import 'package:bl_inshort/features/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // ✅ BLACK status bar + WHITE icons
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // 👈 solid black
      statusBarIconBrightness: Brightness.light, // Android (white icons)
      statusBarBrightness: Brightness.dark, // iOS (white icons)
    ),
  );
  await MobileAds.instance.initialize();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final themeController = ThemeController();
  await themeController.loadTheme();
  runApp(const ProviderScope(child: App()));
}
