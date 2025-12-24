import 'package:bl_inshort/data/dto/notifications/notification_action_dto.dart';
import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';

class NotificationAction {
  final NotificationTargetType type;

  /// Generic payload – interpreted by handler
  final Map<String, dynamic>? payload;

  const NotificationAction({
    required this.type,
    this.payload,
  });

  factory NotificationAction.fromDto(NotificationActionDTO dto) {
    return NotificationAction(
      type: dto.type,
      payload: dto.payload,
    );
  }
}
