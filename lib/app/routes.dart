// import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
// import 'package:bl_inshort/features/feed/presentation/feed_page.dart';
// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bl_inshort/features/shell/home_shell_page.dart';


/// Named routes for clarity
// enum AppRoute {
//   feed,
//   discover,
// }

// GoRouter buildRouter() {
//   return GoRouter(
//     initialLocation: '/discover',
//     routes: [
//       GoRoute(
//         path: '/feed',
//         name: AppRoute.feed.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: FeedPage(),
//         ),
//       ),
//       GoRoute(
//         path: '/discover',
//         name: AppRoute.discover.name,
//         pageBuilder: (context, state) => const NoTransitionPage(
//           child: DiscoverPage(),
//         ),
//       ),
//     ],
//   );
// }


// import 'package:shortnews/features/shell/home_shell_page.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: HomeShellPage(),
        ),
      ),
      // later: add story/detail routes here
      // GoRoute(
      //   path: '/story/:id',
      //   builder: (context, state) => StoryPage(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
