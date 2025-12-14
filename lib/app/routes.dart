import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
import 'package:bl_inshort/features/feed/providers.dart';
import 'package:bl_inshort/features/feedback/presentation/feedback_page.dart';
import 'package:bl_inshort/features/feedback/presentation/widgets/new_feedback_page.dart';
import 'package:bl_inshort/features/notifications/presentation/notifications_page.dart';
import 'package:bl_inshort/features/preferences/presentation/preferences_page.dart';
import 'package:bl_inshort/features/settings/presentation/settings_page.dart';
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
        builder: (context, state) => AdvancedWebView(
          initialUrl: "https://tejasflutter121124.oneapp.dev/",
          title: 'Notifications',
          injectCSS: '',
          injectJS: "",
          enableJavaScript: true,
          showAppBar: true,
        )
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage()
      ),
      GoRoute(
        path: '/preferences',
        builder: (context, state) => const PreferencesPage()
      ),
      GoRoute(
        path: '/feedback',
        builder: (_, __) => const FeedbackPage(),
      ),
      GoRoute(
        path: '/new-feedback',
        builder: (_, __) => const NewFeedbackPage(),
      ),
      GoRoute(
        path: '/feed',
        builder: (_, __) => const FeedPage(),
      ),
      GoRoute(
        path: '/search',
        builder: (_, __) => const SearchPage(),
      ),

      // later: add story/detail routes here
      // GoRoute(
      //   path: '/story/:id',
      //   builder: (context, state) => StoryPage(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
