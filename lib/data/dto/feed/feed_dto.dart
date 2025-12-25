import 'package:bl_inshort/data/dto/common/author_dto.dart';
import 'package:bl_inshort/data/dto/common/source_dto.dart';
import 'package:bl_inshort/data/dto/common/category_dto.dart';
import 'package:bl_inshort/data/dto/common/tag_dto.dart';
import 'package:bl_inshort/data/dto/common/language_dto.dart';
import 'package:bl_inshort/data/dto/common/region_dto.dart';
import 'package:bl_inshort/data/dto/common/status_dto.dart';
import 'package:bl_inshort/data/dto/common/resource_dto.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';

enum FeedLayoutType {
  photoDominant, // big image, small text
  textDominant, // more text, image secondary
  gallery, // horizontal image slider
  story, // story-like full-bleed layout
  htmlViewCard, // card with static html preview
  browserCard, // card with link to external browser
  standardCard; // card with link to external browser

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

class FeedDTO {
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

  FeedDTO({
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

  factory FeedDTO.fromJson(Map<String, dynamic> json) {
    return FeedDTO(
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
      tags: (json['tags'] as List).map((e) => TagDto.fromJson(e)).toList(),
      language: LanguageDto.fromJson(json['language']),
      region: RegionDto.fromJson(json['region']),
      status: StatusDto.fromJson(json['status']),
      resources: (json['resources'] as List)
          .map((e) => ResourceDto.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'FeedDTO{id=$id, title=$title, subtitle=$subtitle, description=$description, slug=$slug, publishedAt=$publishedAt, isFeatured=$isFeatured, engagementScore=$engagementScore, webUrl=$webUrl, html=$html, type=$type, author=$author, source=$source, category=$category, tags=$tags, language=$language, region=$region, status=$status, layout=$layout, resources=$resources}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'slug': slug,
      'published_at': publishedAt,
      'is_featured': isFeatured,
      'engagement_score': engagementScore,
      'web_url': webUrl,
      'html': html,
      'type': type.name,
      'author': author.toJson(),
      'source': source.toJson(),
      'category': category.toJson(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'language': language.toJson(),
      'region': region.toJson(),
      'status': status.toJson(),
      'layout': layout.name,
      'resources': resources.map((e) => e.toJson()).toList(),
    };
  }

  FeedEntity toEntity() {
    return FeedEntity(
      id: id,
      type: type,
      title: title,
      subtitle: subtitle,
      description: description,
      slug: slug,
      webUrl: webUrl,
      html: html,
      publishedAt: DateTime.parse(publishedAt),
      isFeatured: isFeatured,
      engagementScore: engagementScore,
      author: author.toEntity(),
      layout: layout,
      source: source.toEntity(),
      category: category.toEntity(),
      tags: tags.map((e) => e.toEntity()).toList(),
      language: language.toEntity(),
      region: region.toEntity(),
      status: status.toEntity(),
      resources: resources.map((e) => e.toEntity()).toList(),
    );
  }
}
