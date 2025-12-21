import 'package:bl_inshort/data/dto/feed/feed_dto.dart';

class FeedResponseDto {
  final String? cursor;
  final bool hasMore;
  final List<NewsDto> items;

  FeedResponseDto({
    required this.cursor,
    required this.hasMore,
    required this.items,
  });

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) {
    return FeedResponseDto(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      items: (json['items'] as List)
          .map((e) => NewsDto.fromJson(e))
          .toList(),
    );
  }
}
