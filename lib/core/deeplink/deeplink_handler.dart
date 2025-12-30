import 'package:bl_inshort/core/deeplink/deeplink_registry.dart';
import 'package:bl_inshort/core/deeplink/deeplink_resolver.dart';
import 'package:flutter/material.dart';
import 'package:bl_inshort/core/deeplink/deeplink.dart';
import 'package:go_router/go_router.dart';

class DeepLinkHandler {
  static void handle(BuildContext context, Uri uri) {
    final link = DeepLink.fromUri(uri);
    final intent = DeepLinkRegistry.resolve(link);
    final route = DeepLinkResolver.resolve(intent);

    context.go(route);
  }
}
