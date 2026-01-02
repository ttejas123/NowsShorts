import 'package:bl_inshort/features/webview/presentation/webview_page.dart';
import 'package:flutter/material.dart';

class SourceView extends StatelessWidget {
  const SourceView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvancedWebView(
            initialUrl: "https://www.google.com",
      );
  }
}