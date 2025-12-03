import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'widgets/discover_poll_card.dart';
import 'widgets/discover_category_grid.dart';
import 'widgets/discover_topics_carousel.dart';
import 'widgets/discover_notifications_list.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.surface,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // already on Discover
              },
              child: Text(
                'Discover',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                context.go('/feed');
              },
              child: Text(
                'My Feed',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.onSurface.withOpacity(0.5),
                    ),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                // context.go('/notifications');
                context.go('/webview/analytic');
              },
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.notifications_outlined),
              ),
          ),
          
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search (beta)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: DiscoverPollCard(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: DiscoverCategoryGrid(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          const SliverToBoxAdapter(
            child: DiscoverTopicsCarousel(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),

          const SliverToBoxAdapter(
            child: DiscoverNotificationsList(),
          ),
          // const SliverToBoxAdapter(
          //   child: SizedBox(height: 24),
          // ),
        ],
      ),
    );
  }
}
