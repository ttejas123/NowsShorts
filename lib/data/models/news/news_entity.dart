import 'package:bl_inshort/data/dto/feed/news_dto.dart';
import 'package:bl_inshort/data/models/news/author_entity.dart';
import 'package:bl_inshort/data/models/news/category_entity.dart';
import 'package:bl_inshort/data/models/news/language_entity.dart';
import 'package:bl_inshort/data/models/news/region_entity.dart';
import 'package:bl_inshort/data/models/news/resource_entity.dart';
import 'package:bl_inshort/data/models/news/source_entity.dart';
import 'package:bl_inshort/data/models/news/status_entity.dart';
import 'package:bl_inshort/data/models/news/tag_entity.dart';

class NewsEntity {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final DateTime publishedAt;
  final String slug;
  final String webUrl;
  final String html;

  final AuthorEntity author;
  final SourceEntity source;
  final CategoryEntity category;
  final List<TagEntity> tags;
  final LanguageEntity language;
  final RegionEntity region;
  final NewsLayoutType layout;
  final StatusEntity status;

  final bool isFeatured;
  final double engagementScore;

  final List<ResourceEntity> resources;

  NewsEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.publishedAt,
    required this.slug,
    required this.author,
    required this.source,
    required this.category,
    required this.tags,
    required this.language,
    required this.region,
    required this.status,
    required this.isFeatured,
    required this.engagementScore,
    required this.resources,
    required this.layout,
    required this.webUrl,
    required this.html
  });

  factory NewsEntity.fromDto(NewsDto dto) {
    return NewsEntity(
      id: dto.id,
      title: dto.title,
      subtitle: dto.subtitle,
      description: dto.description,
      slug: dto.slug,
      webUrl: dto.webUrl,
      html: dto.html,
      publishedAt: DateTime.parse(dto.publishedAt),
      isFeatured: dto.isFeatured,
      engagementScore: dto.engagementScore,

      author: AuthorEntity.fromDto(dto.author),
      source: SourceEntity.fromDto(dto.source),
      category: CategoryEntity.fromDto(dto.category),
      tags: dto.tags.map(TagEntity.fromDto).toList(),
      language: LanguageEntity.fromDto(dto.language),
      region: RegionEntity.fromDto(dto.region),
      status: StatusEntity.fromDto(dto.status),
      resources: dto.resources.map(ResourceEntity.fromDto).toList(),
      layout: dto.layout,
    );
  }
}
