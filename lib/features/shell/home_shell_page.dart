import 'package:bl_inshort/features/profile/presentation/profile_page.dart';
import 'package:bl_inshort/features/search/presentation/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation_providers.dart';
import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
import 'package:bl_inshort/features/feed/presentation/feed_page.dart';

class HomeShellPage extends ConsumerWidget {
  const HomeShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final controller = ref.read(bottomNavIndexProvider.notifier);

    // Use IndexedStack to preserve state of each tab
    Widget body = IndexedStack(
      index: currentIndex,
      children: const [
        DiscoverPage(),
        FeedPage(),
        SearchPage(),
        ProfilePage(),
      ],
    );

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
