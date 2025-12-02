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
        pageSize: 5, // initial batch size, tweak as needed
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

  List<NewsItemEntity> get _allNews => _read(allNewsProvider);

  Future<void> loadInitial() async {
    if (state.isInitialLoading) return;

    state = state.copyWith(
      isInitialLoading: true,
      error: null,
    );

    try {
      final all = _allNews;
      final slice = all.take(state.pageSize).toList();

      state = state.copyWith(
        isInitialLoading: false,
        items: slice,
        hasMore: slice.length < all.length,
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
      final all = _allNews;
      final currentLength = state.items.length;
      final nextEnd = min(currentLength + state.pageSize, all.length);
      final more = all.sublist(currentLength, nextEnd);

      state = state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...more],
        hasMore: nextEnd < all.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e,
      );
    }
  }
}
