import 'package:bl_inshort/data/dto/feed/feed_dto.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';

class FeedResponseDto {
  final String? cursor;
  final bool hasMore;
  final List<FeedDTO> items;

  FeedResponseDto({
    required this.cursor,
    required this.hasMore,
    required this.items,
  });

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) {
    return FeedResponseDto(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      items: (json['items'] as List).map((e) => FeedDTO.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'FeedResponseDto{cursor=$cursor, hasMore=$hasMore, items=$items}';
  }

  Map<String, dynamic> toJson() {
    return {
      'cursor': cursor,
      'has_more': hasMore,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  static List<FeedEntity> toEntityFromJson(Map<String, dynamic> json) {
    return FeedResponseDto.fromJson(
      json,
    ).items.map((dto) => dto.toEntity()).toList();
  }
}
