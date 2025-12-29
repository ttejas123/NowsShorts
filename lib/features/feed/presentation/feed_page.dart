import 'package:bl_inshort/core/ads/ads_providers.dart';
import 'package:bl_inshort/core/ads/presentation/ad_slot_widget.dart';
import 'package:bl_inshort/data/dto/feed/feed_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bl_inshort/features/feed/providers.dart';
import 'package:go_router/go_router.dart';
import 'widgets/feed_cards.dart';

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

    // Infinite scroll trigger (we’ll keep this, but it now works with snapping too)
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
    final adsRuntime = ref.watch(adsRuntimeProvider);
    final state = ref.watch(feedControllerProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    if (state.isInitialLoading && state.items.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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

    if (state.items.isEmpty) {
      return const Scaffold(body: Center(child: Text('No news yet')));
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // 👈 let body draw behind appbar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          color: colors.onSurfaceVariant,
        ),
        backgroundColor:
            Colors.transparent, // 👈 transparent background (no solid bar)
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('My Feed', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false, // 👈 we’re already handling via AppBar
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemHeight = constraints.maxHeight; // visible viewport height

            return ListView.builder(
              controller: _scrollController,
              physics: const PageScrollPhysics(), // snap like PageView
              padding: EdgeInsets.zero,
              itemExtent: itemHeight,
              // how many items to keep offscreen (tune this for memory)
              cacheExtent: itemHeight * 1.5, // roughly next + previous
              itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                // Show loading indicator at end while loading more
                if (index == state.items.length - 2 && state.isLoadingMore) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (index >= state.items.length) {
                  return const SizedBox.shrink();
                }

                final item = state.items[index];

                // Advertisement
                if (item.provider.type == ItemType.Advertisement) {
                  return AdSlotWidget(
                    meta: item,
                    runtime: adsRuntime,
                    fallback: FeedCard(item: item),
                  );
                }

                // News
                return FeedCard(item: item);
              },
            );
          },
        ),
      ),
    );
  }
}
