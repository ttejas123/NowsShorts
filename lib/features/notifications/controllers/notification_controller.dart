// lib/features/feed/controllers/feed_controller.dart
import 'package:bl_inshort/data/models/notifications/notification_entity.dart';
import 'package:bl_inshort/data/repositories/notification_repository.dart';
import 'package:bl_inshort/features/notifications/provider.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';

typedef Reader = T Function<T>(ProviderListenable<T>);

class NotificationState {
  final List<NotificationEntity> items;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int pageSize;
  final Object? error;

  const NotificationState({
    required this.items,
    required this.isInitialLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.pageSize,
    required this.error,
  });

  factory NotificationState.initial() => const NotificationState(
        items: [],
        isInitialLoading: false,
        isLoadingMore: false,
        hasMore: true,
        pageSize: 5,
        error: null,
      );

  NotificationState copyWith({
    List<NotificationEntity>? items,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? pageSize,
    Object? error,
  }) {
    return NotificationState(
      items: items ?? this.items,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      pageSize: pageSize ?? this.pageSize,
      error: error,
    );
  }
}

class NotificationController extends StateNotifier<NotificationState> {
  NotificationController(this._read) : super(NotificationState.initial());

  final Reader _read;

  NotificationRepository get _repo => _read(notificationRepositoryProvider);

  Future<void> loadInitial() async {
    if (state.isInitialLoading) return;

    state = state.copyWith(
      isInitialLoading: true,
      error: null,
    );

    try {
      final items = await _repo.fetchNotification();

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
      final items = await _repo.fetchNotification();

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