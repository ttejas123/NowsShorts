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
          initialUrl: "https://tejasflutter121124.oneapp.dev/",
          title: 'Campaign',
          injectCSS: '',
          injectJS: "",
          enableJavaScript: true,
          showAppBar: true,
        )
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => AdvancedWebView(
          initialUrl: "https://tejasflutter121132.oneapp.dev/",
          title: '',
          injectCSS: '',
          injectJS: "",
          enableJavaScript: true,
          showAppBar: false,
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
