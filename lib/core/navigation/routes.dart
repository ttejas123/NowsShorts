import 'package:bl_inshort/core/logging/Console.dart';
import 'package:bl_inshort/data/models/feeds/language_entity.dart';
import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
import 'package:bl_inshort/features/feedback/presentation/feedback_page.dart';
import 'package:bl_inshort/features/feedback/presentation/widgets/feed_feedback_page.dart';
import 'package:bl_inshort/features/onboarding/presentation/language_selection_screen.dart';
import 'package:bl_inshort/features/onboarding/presentation/region_selection_screen.dart';
import 'package:bl_inshort/features/preferences/presentation/preferences_page.dart';
import 'package:bl_inshort/features/settings/presentation/settings_page.dart';
import 'package:bl_inshort/features/settings/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bl_inshort/features/shell/home_shell_page.dart';

GoRouter buildRouter(WidgetRef ref) {
  final settings = ref.watch(settingsControllerProvider);
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          Console.log(
            "settings init=${settings.isInitialized}, lang=${settings.selectedLanguage}, regions=${settings.selectedRegions}",
          );

          // 🔄 Still loading → show splash / loader
          if (!settings.isInitialized) {
            return const SizedBox(); // or SplashScreen
          }

          // ✅ Onboarded
          if (settings.selectedLanguage != null &&
              settings.selectedRegions.isNotEmpty) {
            return const HomeShellPage();
          }

          return const LanguageSelectionScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeShellPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => RegionSelectionScreen(
          language: LanguageEntity(id: 1, name: 'English', code: 'en'),
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/preferences',
        builder: (context, state) => const PreferencesPage(),
      ),
      GoRoute(path: '/feedback', builder: (_, _) => const FeedbackPage()),
      GoRoute(
        path: '/new-feedback',
        builder: (_, _) => const NewFeedbackPage(),
      ),
      GoRoute(path: '/feed', builder: (_, _) => const FeedPage()),
      GoRoute(path: '/search', builder: (_, _) => const SearchPage()),

      // later: add story/detail routes here
      // GoRoute(
      //   path: '/story/:id',
      //   builder: (context, state) => StoryPage(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
