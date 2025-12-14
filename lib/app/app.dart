import 'package:bl_inshort/app/routes.dart';
import 'package:bl_inshort/features/theme/theme_provider.dart';
import 'package:bl_inshort/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class App extends ConsumerStatefulWidget {
  const App({ super.key });

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async {
    // Perform any initialization tasks here
    // await Future.delayed(const Duration(seconds: 4)); // Simulate a delay
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(ref);
    final themeController = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: 'BL News',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      routerConfig: router,
    );

  }
}