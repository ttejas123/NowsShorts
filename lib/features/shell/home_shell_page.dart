import 'package:bl_inshort/features/profile/presentation/profile_page.dart';
import 'package:bl_inshort/features/search/presentation/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation_providers.dart';
import 'package:bl_inshort/features/discover/presentation/discover_page.dart';
import 'package:bl_inshort/features/feed/presentation/feed_page.dart';

class HomeShellPage extends ConsumerStatefulWidget {
  const HomeShellPage({super.key});

  @override
  ConsumerState<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends ConsumerState<HomeShellPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialIndex = ref.read(bottomNavIndexProvider);
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final controller = ref.read(bottomNavIndexProvider.notifier);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // 👈 disables swipe
        onPageChanged: (index) {
          // update bottom nav when user swipes
          controller.state = index;
        },
        children: const [
          DiscoverPage(),
          FeedPage(),
          SearchPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.state = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
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
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}