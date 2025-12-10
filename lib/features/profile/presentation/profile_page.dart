import 'package:bl_inshort/features/webview/presentation/webview_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: AdvancedWebView(
            initialUrl: "https://appflutter1211342.oneapp.dev/",
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
