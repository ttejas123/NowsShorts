import 'package:bl_inshort/features/webview/presentation/webview_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: const Center(
        child: AdvancedWebView(
            initialUrl: "https://tejasflutter121132.oneapp.dev/",
            title: '',
            injectCSS: '',
            injectJS: "",
            enableJavaScript: true,
            showAppBar: false,
        ),
      ),
    );
  }
}
