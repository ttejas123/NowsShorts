import 'package:bl_inshort/data/dto/notifications/notification_dto.dart';
import 'package:bl_inshort/data/models/notifications/notification_action.dart';
import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';
import 'package:bl_inshort/data/models/notifications/notification_presentation.dart';
import 'package:bl_inshort/data/models/notifications/notification_state.dart';



class NotificationEntity {
  final String id;

  /// WHY this notification exists
  final NotificationIntent intent;

  /// HOW important / aggressive
  final NotificationPriority priority;

  /// WHERE it should take the user
  final NotificationAction action;

  /// OPTIONAL: visual hints for in-app UI
  final NotificationPresentation? presentation;

  /// LIFECYCLE
  final NotificationState state;

  /// METADATA (analytics, experiments, ML, flags)
  final Map<String, dynamic>? metadata;

  /// TIMING
  final DateTime createdAt;
  final DateTime? expiresAt;

  const NotificationEntity({
    required this.id,
    required this.intent,
    required this.priority,
    required this.action,
    this.presentation,
    required this.state,
    this.metadata,
    required this.createdAt,
    this.expiresAt,
  });

  factory NotificationEntity.fromDto(NotificationDTO dto) {
    return NotificationEntity(
      id: dto.id,
      action: NotificationAction.fromDto(dto.action),
      intent: dto.intent,
      state: NotificationState.fromDto(dto.state),
      presentation: dto.presentation.toEntity(),
      priority: dto.priority,
      createdAt: DateTime.parse(dto.created_at),
      expiresAt: dto.expires_at != null ? DateTime.parse(dto.expires_at!) : null,
      metadata: dto.metadata,
    );
  }
}
