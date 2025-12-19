import 'package:bl_inshort/data/dto/feed/news_dto.dart';
import 'package:bl_inshort/data/models/news/author_entity.dart';
import 'package:bl_inshort/data/models/news/category_entity.dart';
import 'package:bl_inshort/data/models/news/content_type_entity.dart';
import 'package:bl_inshort/data/models/news/language_entity.dart';
import 'package:bl_inshort/data/models/news/region_entity.dart';
import 'package:bl_inshort/data/models/news/resource_entity.dart';
import 'package:bl_inshort/data/models/news/source_entity.dart';
import 'package:bl_inshort/data/models/news/status_entity.dart';
import 'package:bl_inshort/data/models/news/tag_entity.dart';

class NewsEntity {
  final int id;
  final String title;
  final String description;
  final DateTime publishedAt;
  final String slug;

  final AuthorEntity author;
  final SourceEntity source;
  final CategoryEntity category;
  final List<TagEntity> tags;
  final LanguageEntity language;
  final RegionEntity region;

  final StatusEntity status;
  final ContentTypeEntity contentType;

  final bool isFeatured;
  final double engagementScore;

  final List<ResourceEntity> resources;

  NewsEntity({
    required this.id,
    required this.title,
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
    required this.contentType,
    required this.isFeatured,
    required this.engagementScore,
    required this.resources,
  });

  factory NewsEntity.fromDto(NewsDto dto) {
    return NewsEntity(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      slug: dto.slug,
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
      contentType: ContentTypeEntity.fromDto(dto.contentType),
      resources: dto.resources.map(ResourceEntity.fromDto).toList(),
    );
  }
}
