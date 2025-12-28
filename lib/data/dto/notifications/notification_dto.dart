import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';
import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';
import 'package:bl_inshort/data/models/notifications/notification_entity.dart';

import 'notification_action_dto.dart';
import 'notification_presentation_dto.dart';
import 'notification_state_dto.dart';

class NotificationDTO extends FactorySafeDto<NotificationDTO> {
  final String id;

  /// intent = breaking / recommendation / reminder etc
  final NotificationIntent intent;

  /// priority = max / high / normal / low
  final NotificationPriority priority;

  /// routing / deeplink
  final NotificationActionDTO action;

  /// optional UI hints
  final NotificationPresentationDTO? presentation;

  /// read / delivered / opened
  final NotificationStateDTO state;

  /// analytics / experiments
  final Map<String, dynamic>? metadata;

  final String created_at;
  final String? expires_at;

  NotificationDTO({
    required this.id,
    required this.intent,
    required this.priority,
    required this.action,
    this.presentation,
    required this.state,
    this.metadata,
    required this.created_at,
    this.expires_at,
  });

  NotificationDTO fromJson(Map<String, dynamic> json) {
    final dto = NotificationDTO(
      id: json['id'],
      intent: NotificationIntent.fromString(json['intent']),
      priority: NotificationPriority.fromString(json['priority']),
      action: NotificationActionDTO.prototype().fromJson(json['action']),
      presentation: json['presentation'] != null
          ? NotificationPresentationDTO.prototype().fromJson(
              json['presentation'],
            )
          : null,
      state: NotificationStateDTO.prototype().fromJson(json['state']),
      metadata: json['metadata'],
      created_at: json['createdAt'] ?? json['created_at'],
      expires_at: json['expiresAt'] ?? json['expires_at'],
    );

    return dto;
  }

  factory NotificationDTO.prototype() {
    return NotificationDTO(
      id: "-1",
      intent: NotificationIntent.breaking,
      priority: NotificationPriority.high,
      action: NotificationActionDTO.prototype(),
      presentation: NotificationPresentationDTO.prototype(),
      state: NotificationStateDTO.prototype(),
      metadata: {},
      created_at: "",
      expires_at: "",
    );
  }

  @override
  String toString() {
    return 'NotificationDTO{id=$id, intent=$intent, priority=$priority, action=$action, presentation=$presentation, state=$state, metadata=$metadata, created_at=$created_at, expires_at=$expires_at}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intent': intent.name,
      'priority': priority.name,
      'action': action.toJson(),
      'presentation': presentation?.toJson(),
      'state': state.toJson(),
      'metadata': metadata,
      'created_at': created_at,
      'expires_at': expires_at,
    };
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      intent: intent,
      priority: priority,
      action: action.toEntity(),
      presentation: presentation?.toEntity(),
      state: state.toEntity(),
      metadata: metadata,
      createdAt: DateTime.parse(created_at),
      expiresAt: expires_at != null ? DateTime.parse(expires_at!) : null,
    );
  }
}
