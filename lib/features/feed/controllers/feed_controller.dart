// lib/features/feed/controllers/feed_controller.dart
import 'package:bl_inshort/data/repositories/feed_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';

import 'package:bl_inshort/features/feed/providers.dart';
import 'package:bl_inshort/data/models/news/news_entity.dart';

typedef Reader = T Function<T>(ProviderListenable<T>);

class FeedState {
  final List<NewsEntity> items;
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
        pageSize: 5,
        error: null,
      );

  FeedState copyWith({
    List<NewsEntity>? items,
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

  FeedRepository get _repo => _read(feedRepositoryProvider);

  Future<void> loadInitial() async {
    if (state.isInitialLoading) return;

    state = state.copyWith(
      isInitialLoading: true,
      error: null,
    );

    try {
      final items = await _repo.fetchFeed();

      state = state.copyWith(
        isInitialLoading: false,
        items: items,
        hasMore: true, // still infinite for now
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
      final items = await _repo.fetchFeed();

      state = state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...items],
        hasMore: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e,
      );
    }
  }
}