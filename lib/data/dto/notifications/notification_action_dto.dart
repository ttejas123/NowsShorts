import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';
import 'package:bl_inshort/data/models/notifications/notification_action.dart';
import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';

class NotificationActionDTO extends FactorySafeDto<NotificationActionDTO> {
  /// feed / webview / externalUrl / none
  final NotificationTargetType type;

  /// flexible payload
  final Map<String, dynamic>? payload;

  NotificationActionDTO({required this.type, this.payload});

  NotificationActionDTO fromJson(Map<String, dynamic> json) {
    return NotificationActionDTO(
      type: NotificationTargetType.fromString(json['type'] ?? 'none'),
      payload: json['payload'],
    );
  }

  factory NotificationActionDTO.prototype() {
    return NotificationActionDTO(
      type: NotificationTargetType.none,
      payload: null,
    );
  }

  @override
  String toString() {
    return 'NotificationActionDTO{type=$type, payload=$payload}';
  }

  Map<String, dynamic> toJson() {
    return {'type': type.name, 'payload': payload};
  }

  NotificationAction toEntity() {
    return NotificationAction(type: type, payload: payload);
  }
}
