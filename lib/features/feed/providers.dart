// lib/features/feed/providers.dart

import 'package:bl_inshort/features/feed/controllers/feed_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bl_inshort/core/network/api_client.dart';
import 'package:bl_inshort/data/repositories/feed_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(mockMode: true);
});

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  final client = ref.read(apiClientProvider);
  return FeedRepository(client.dio);
});

final feedControllerProvider =
    StateNotifierProvider<FeedController, FeedState>((ref) {
  return FeedController(ref.read);
});
