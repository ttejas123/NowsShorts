import 'package:bl_inshort/data/models/notifications/notification_action.dart';
import 'package:bl_inshort/data/models/notifications/notification_common_enums.dart';
import 'package:bl_inshort/data/models/notifications/notification_entity.dart';
import 'package:bl_inshort/data/models/notifications/notification_presentation.dart';
import 'package:bl_inshort/data/models/notifications/notification_state.dart';
/*
  TODO: toString(), toJson() and toHash() methods 
  And we have to rename this function as  
      1) toString = toStringPrint 
      2) toJson = toJsonPrint 
      3) toHash = toHashPrint
*/

extension NotificationActionExtension on NotificationAction {
  String toStringPrint() {
    return 'NotificationAction{type: $type, payload: $payload}';
  }

  Map<String, dynamic> toJsonPrint() {
    return {'type': type, 'payload': payload};
  }
}

extension NotificationStateExtension on NotificationState {
  String toStringPrint() {
    return 'NotificationState(isRead: $isRead, isDismissed: $isDismissed, delivered: $delivered, opened: $opened)';
  }

  Map<String, dynamic> toJsonPrint() {
    return {
      'isRead': isRead,
      'isDismissed': isDismissed,
      'delivered': delivered,
      'opened': opened,
    };
  }
}

extension NotificationPresentationExtension on NotificationPresentation {
  String toStringPrint() {
    return 'NotificationPresentation(title: $title, subtitle: $subtitle, body: $body, resources: $resources, highlight: $highlight, badge: $badge)';
  }

  Map<String, dynamic> toJsonPrint() {
    return {
      'title': title,
      'subtitle': subtitle,
      'body': body,
      'resources': resources,
      'highlight': highlight,
      'badge': badge,
    };
  }
}

extension NotificationEntityExtension on NotificationEntity {
  String toStringPrint() {
    return 'NotificationEntity(id: $id, intent: $intent, priority: $priority, action: $action, presentation: $presentation, state: $state, metadata: $metadata, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  Map<String, dynamic> toJsonPrint() {
    return {
      'id': id,
      'intent': intent,
      'priority': priority.name,
      'action': action.toJsonPrint(),
      'presentation': presentation?.toJsonPrint(),
      'state': state.toJsonPrint(),
      'metadata': metadata,
      'createdAt': createdAt,
      'expiresAt': expiresAt,
    };
  }
}

extension NotificationIntentExtension on NotificationIntent {
  NotificationIntent fromString(String value) {
    return NotificationIntent.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationIntent.silent,
    );
  }
}
