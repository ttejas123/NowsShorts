import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import 'package:shortnews/features/feed/presentation/feed_page.dart';
// import 'package:shortnews/features/discover/presentation/discover_page.dart';

/// Named routes for clarity
enum AppRoute {
  feed,
  discover,
}

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/discover',
    routes: [
      GoRoute(
        path: '/feed',
        name: AppRoute.feed.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: FeedPage(),
        ),
      ),
      GoRoute(
        path: '/discover',
        name: AppRoute.discover.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: DiscoverPage(),
        ),
      ),
    ],
  );
}
