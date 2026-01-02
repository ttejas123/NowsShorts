import 'package:bl_inshort/core/deeplink/deeplink_registry.dart';
import 'package:bl_inshort/core/deeplink/deeplink_resolver.dart';
import 'package:bl_inshort/core/logging/Console.dart';
import 'package:flutter/material.dart';
import 'package:bl_inshort/core/deeplink/deeplink.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkHandler {
  static void handle(BuildContext context, Uri uri) {
    final link = DeepLink.fromUri(uri);
    final intent = DeepLinkRegistry.resolve(link);
    final route = DeepLinkResolver.resolve(intent);
    context.go(route);
  }

  static void init(BuildContext context) {
    // Cold start
    getInitialUri().then((uri) {
      if (uri != null) {
        handle(context, uri);
      }
    });

    // App already running
    uriLinkStream.listen((uri) {
      if (uri != null) {
        handle(context, uri);
      }
    });
  }
}
