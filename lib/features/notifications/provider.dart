import 'package:bl_inshort/data/repositories/notification_repository.dart';
import 'package:bl_inshort/features/notifications/controllers/notification_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bl_inshort/core/network/api_client.dart';
import 'package:flutter_riverpod/legacy.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(mockMode: true);
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final client = ref.read(apiClientProvider);
  return NotificationRepository(client.dio);
});

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, NotificationState>((ref) {
  return NotificationController(ref.read);
});