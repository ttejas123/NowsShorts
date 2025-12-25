import 'package:bl_inshort/data/dto/notifications/notification_response_dto.dart';
import 'package:bl_inshort/data/models/notifications/notification_entity.dart';
import 'package:dio/dio.dart';

abstract class NotificationRepositoryAbstract {
  Future<List<NotificationEntity>> fetchNotification();
  Future<void> markAsRead(int notificationId);
  Future<void> dismiss(int notificationId);
}

class NotificationRepository extends NotificationRepositoryAbstract {
  final Dio dio;

  NotificationRepository(this.dio);

  @override
  Future<List<NotificationEntity>> fetchNotification() async {
    final response = await dio.get("/notification");
    final notificationDto = NotificationResponseDTO.fromJson(response.data);
    return notificationDto.items
        .map((dto) => NotificationEntity.fromDto(dto))
        .toList();
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    await dio.post("/notification/markAsRead", data: {
      "id": notificationId,
    });
  }

  @override
  Future<void> dismiss(int notificationId) async {
    await dio.post("/notification/dismiss", data: {
      "id": notificationId,
    });
  }
}