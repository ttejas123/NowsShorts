// import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
// import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
// import 'package:flutter/material.dart';
import 'package:bl_inshort/features/feed/providers.dart';
import 'package:bl_inshort/features/notifications/presentation/notifications_page.dart';
import 'package:bl_inshort/features/webview/presentation/webview_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bl_inshort/features/shell/home_shell_page.dart';

GoRouter buildRouter(WidgetRef ref) {

  final s = ref.watch(HtmlTemplateViewProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: HomeShellPage(),
        ),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/webview/analytic',
        builder: (context, state) => AdvancedWebView(
          initialHtml: s,
          title: 'Campaign',
          injectCSS: 'body { background: #fff; color: #111 } img { max-width:100% }',
          injectJS: "console.log('campaign loaded')",
          enableJavaScript: true,
          showAppBar: true,
        )
      ),
      // later: add story/detail routes here
      // GoRoute(
      //   path: '/story/:id',
      //   builder: (context, state) => StoryPage(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
