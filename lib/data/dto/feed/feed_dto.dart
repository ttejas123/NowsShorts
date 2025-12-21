import 'package:bl_inshort/data/dto/common/author_dto.dart';
import 'package:bl_inshort/data/dto/common/source_dto.dart';
import 'package:bl_inshort/data/dto/common/category_dto.dart';
import 'package:bl_inshort/data/dto/common/tag_dto.dart';
import 'package:bl_inshort/data/dto/common/language_dto.dart';
import 'package:bl_inshort/data/dto/common/region_dto.dart';
import 'package:bl_inshort/data/dto/common/status_dto.dart';
import 'package:bl_inshort/data/dto/common/resource_dto.dart';

enum FeedLayoutType {
  photoDominant, // big image, small text
  textDominant,  // more text, image secondary
  gallery,       // horizontal image slider
  story,         // story-like full-bleed layout
  htmlViewCard,   // card with static html preview
  browserCard,   // card with link to external browser
  standardCard;   // card with link to external browser

  static FeedLayoutType fromString(String value) {
    return FeedLayoutType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => FeedLayoutType.standardCard,
    );
  }
}

enum ItemType {
  News,
  Advertisement,
  SponsoredContent,
  Announcement;

  static ItemType fromString(String value) {
    return ItemType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ItemType.News,
    );
  }
}

class NewsDto {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final String slug;
  final String publishedAt;
  final bool isFeatured;
  final double engagementScore;
  final String webUrl;
  final String html;
  final ItemType type;

  final AuthorDto author;
  final SourceDto source;
  final CategoryDto category;
  final List<TagDto> tags;
  final LanguageDto language;
  final RegionDto region;
  final StatusDto status;
  final FeedLayoutType layout;
  final List<ResourceDto> resources;

  NewsDto({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.slug,
    required this.publishedAt,
    required this.isFeatured,
    required this.engagementScore,
    required this.author,
    required this.source,
    required this.category,
    required this.tags,
    required this.language,
    required this.region,
    required this.status,
    required this.resources,
    required this.layout,
    required this.webUrl,
    required this.html,
  });

  factory NewsDto.fromJson(Map<String, dynamic> json) {
    return NewsDto(
      id: json['id'],
      type: ItemType.fromString(json['type']),
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      slug: json['slug'],
      webUrl: json['web_url'],
      html: json['html'],
      publishedAt: json['published_at'],
      isFeatured: json['is_featured'],
      engagementScore: (json['engagement_score'] as num).toDouble(),
      author: AuthorDto.fromJson(json['author']),
      layout: FeedLayoutType.fromString(json['layout']),
      source: SourceDto.fromJson(json['source']),
      category: CategoryDto.fromJson(json['category']),
      tags: (json['tags'] as List)
          .map((e) => TagDto.fromJson(e))
          .toList(),
      language: LanguageDto.fromJson(json['language']),
      region: RegionDto.fromJson(json['region']),
      status: StatusDto.fromJson(json['status']),
      resources: (json['resources'] as List)
          .map((e) => ResourceDto.fromJson(e))
          .toList(),
    );
  }
}
