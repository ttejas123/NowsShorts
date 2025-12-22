import 'package:bl_inshort/data/dto/notifications/notification_dto.dart';

class NotificationResponseDto {

  final String? cursor;
  final bool hasMore;
  final List<NotificationDTO> items;

  NotificationResponseDto({
    required this.cursor,
    required this.hasMore,
    required this.items,
  });

  factory NotificationResponseDto.fromJson(Map<String, dynamic> json) {
    return NotificationResponseDto(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      items: (json['items'] as List)
          .map((e) => NotificationDTO.fromJson(e))
          .toList(),
    );
  }
}