import 'package:bl_inshort/data/dto/notifications/notification_dto.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';

class NotificationEntity {
  final int id;

  // Display
  final String title;
  final String subtitle;
  final String? body;
  final String? imageUrl;

  // Classification
  final NotificationType type;
  final NotificationPriority priority;

  // Routing
  final NotificationTargetType targetType;
  final String? targetValue; // feedId, url, deeplink, etc.
  final FeedEntity? feedPreview; // optional rich preview

  // State
  final bool isRead;
  final bool isDismissible;

  // Timing
  final DateTime createdAt;
  final DateTime? expiresAt;

  // Analytics
  final String? campaignId;
  final Map<String, dynamic>? metadata;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    this.body,
    this.imageUrl,
    required this.type,
    required this.priority,
    required this.targetType,
    this.targetValue,
    this.feedPreview,
    required this.isRead,
    required this.isDismissible,
    required this.createdAt,
    this.expiresAt,
    this.campaignId,
    this.metadata,
  });

  factory NotificationEntity.fromDto(NotificationDTO dto) {
  return NotificationEntity(
    id: dto.id,
    title: dto.title,
    subtitle: dto.subtitle,
    body: dto.body,
    imageUrl: dto.image_url,
    type: NotificationType.values.byName(dto.type),
    priority: NotificationPriority.values.byName(dto.priority),
    targetType: NotificationTargetType.values.byName(dto.target_type),
    targetValue: dto.target_value,
    isRead: dto.is_read,
    isDismissible: dto.is_dismissible,
    createdAt: DateTime.parse(dto.created_at),
    expiresAt:
        dto.expires_at != null ? DateTime.parse(dto.expires_at!) : null,
    metadata: dto.metadata,
  );
}
}
