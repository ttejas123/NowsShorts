// lib/features/feed/presentation/feed_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bl_inshort/features/feed/providers.dart';

import 'widgets/news_cards.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Load initial batch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedControllerProvider.notifier).loadInitial();
    });

    // Infinite scroll trigger (bottom prefetch)
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 200) {
        ref.read(feedControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedControllerProvider);
    final size = MediaQuery.of(context).size;

    if (state.isInitialLoading && state.items.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null && state.items.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'Failed to load feed.\n${state.error}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          physics: const PageScrollPhysics(), // snap like PageView
          padding: EdgeInsets.zero,
          itemExtent: size.height, // each item is full screen
          itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == state.items.length && state.isLoadingMore) {
              return const Center(child: CircularProgressIndicator());
            }

            if (index >= state.items.length) {
              return const SizedBox.shrink();
            }

            final item = state.items[index];
            return NewsCard(item: item);
          },
        ),
      ),
    );
  }
}
