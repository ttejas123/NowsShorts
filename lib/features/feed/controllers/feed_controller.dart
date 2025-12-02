// lib/features/feed/controllers/feed_controller.dart

import 'dart:math';

import 'package:bl_inshort/data/models/news_item_entity.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';

import 'package:bl_inshort/features/feed/providers.dart';

typedef Reader = T Function<T>(ProviderListenable<T>);

class FeedState {
  final List<NewsItemEntity> items;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int pageSize;
  final Object? error;

  const FeedState({
    required this.items,
    required this.isInitialLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.pageSize,
    required this.error,
  });

  factory FeedState.initial() => const FeedState(
        items: [],
        isInitialLoading: false,
        isLoadingMore: false,
        hasMore: true, 
        pageSize: 5,   // can tune this
        error: null,
      );

  FeedState copyWith({
    List<NewsItemEntity>? items,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? pageSize,
    Object? error,
  }) {
    return FeedState(
      items: items ?? this.items,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      pageSize: pageSize ?? this.pageSize,
      error: error,
    );
  }
}

class FeedController extends StateNotifier<FeedState> {
  FeedController(this._read) : super(FeedState.initial());

  final Reader _read;
  final Random _rng = Random();

  List<NewsItemEntity> get _templates => _read(allNewsProvider);

  Future<void> loadInitial() async {
    if (state.isInitialLoading) return;

    state = state.copyWith(
      isInitialLoading: true,
      error: null,
    );

    try {
      final batch = _generateBatch(
        startIndex: 0,
        count: state.pageSize,
      );

      state = state.copyWith(
        isInitialLoading: false,
        items: batch,
        hasMore: true, // infinite
      );
    } catch (e) {
      state = state.copyWith(
        isInitialLoading: false,
        error: e,
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(
      isLoadingMore: true,
      error: null,
    );

    try {
      final startIndex = state.items.length;
      final batch = _generateBatch(
        startIndex: startIndex,
        count: state.pageSize,
      );

      state = state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...batch],
        hasMore: true, // keep allowing more for now (nextEnd < all.length)
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e,
      );
    }
  }

  /// Generate `count` news items based on templates.
  /// startIndex is used to make IDs and timestamps different.
  List<NewsItemEntity> _generateBatch({
    required int startIndex,
    required int count,
  }) {
    final templates = _templates;
    final List<NewsItemEntity> generated = [];

    final now = DateTime.now();

    for (int i = 0; i < count; i++) {
      final globalIndex = startIndex + i;

      // pick a template in round-robin or random
      final template = templates[globalIndex % templates.length];

      // random-ish layout (you can keep original if you want)
      final layoutTypes = NewsLayoutType.values;
      final randomLayoutType =
          layoutTypes[_rng.nextInt(layoutTypes.length)];

      // random-ish minutes ago
      final minutesAgo = globalIndex * 3 + _rng.nextInt(5);

      final item = NewsItemEntity(
        id: 'news_$globalIndex',
        title: '${template.title} #$globalIndex',
        subtitle: template.subtitle,
        body: template.body,
        imageUrl: template.imageUrl,
        galleryUrls: template.galleryUrls,
        source: template.source,
        publishedAt: now.subtract(Duration(minutes: minutesAgo)),
        layoutType: template.galleryUrls.length > 1
            ? NewsLayoutType.gallery
            : randomLayoutType,
      );

      generated.add(item);
    }

    return generated;
  }
}