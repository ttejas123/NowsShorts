import 'package:bl_inshort/app/routes.dart';
import 'package:bl_inshort/app/theme.dart';
import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(BuildContext context) {
    final router = buildRouter();
    return MaterialApp.router(
      title: 'BL News',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: router,
    );
  }
}