import 'package:bl_inshort/data/models/notifications/notification_action.dart';
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
          .map((e) => NotificationDTO.fromJson(e))
          .toList(),
      hasMore: json['hasMore'] ?? false,
      cursor: json['cursor'],
    );
  }


}
