import 'package:bl_inshort/data/models/notifications/notification_action.dart';
import 'package:bl_inshort/data/models/notifications/notification_entity.dart';
import 'package:flutter/widgets.dart';

import 'notification_dto.dart';

class NotificationResponseDTO {
  final List<NotificationDTO> items;
  final bool hasMore;
  final String? cursor;

  NotificationResponseDTO({
    required this.items,
    required this.hasMore,
    this.cursor,
  });

  factory NotificationResponseDTO.fromJson(Map<String, dynamic> json) {
    return NotificationResponseDTO(
      items: (json['items'] as List)
          .take(1)
          .map((e) => NotificationDTO.fromJson(e))
          .toList(),
      hasMore: json['hasMore'] ?? false,
      cursor: json['cursor'],
    );
  }

  @override
  String toString() {
    return 'NotificationResponseDTO{items=$items, hasMore=$hasMore, cursor=$cursor}';
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'hasMore': hasMore,
      'cursor': cursor,
    };
  }

  static List<NotificationEntity> toEntityFromJson(Map<String, dynamic> json) {
    return NotificationResponseDTO.fromJson(
      json,
    ).items.map((dto) => dto.toEntity()).toList();
  }
}
