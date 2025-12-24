import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';

class NotificationActionDTO {
  /// feed / webview / externalUrl / none
  final NotificationTargetType type;

  /// flexible payload
  final Map<String, dynamic>? payload;

  NotificationActionDTO({
    required this.type,
    this.payload,
  });

  factory NotificationActionDTO.fromJson(Map<String, dynamic> json) {
    return NotificationActionDTO(
      type: NotificationTargetType.fromString(json['type'] ?? 'none'),
      payload: json['payload'],
    );
  }
}
