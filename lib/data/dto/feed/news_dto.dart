import 'package:bl_inshort/data/dto/common/author_dto.dart';
import 'package:bl_inshort/data/dto/common/source_dto.dart';
import 'package:bl_inshort/data/dto/common/category_dto.dart';
import 'package:bl_inshort/data/dto/common/tag_dto.dart';
import 'package:bl_inshort/data/dto/common/language_dto.dart';
import 'package:bl_inshort/data/dto/common/region_dto.dart';
import 'package:bl_inshort/data/dto/common/status_dto.dart';
import 'package:bl_inshort/data/dto/common/content_type_dto.dart';
import 'package:bl_inshort/data/dto/common/resource_dto.dart';

class NewsDto {
  final int id;
  final String title;
  final String description;
  final String slug;
  final String publishedAt;
  final bool isFeatured;
  final double engagementScore;

  final AuthorDto author;
  final SourceDto source;
  final CategoryDto category;
  final List<TagDto> tags;
  final LanguageDto language;
  final RegionDto region;
  final StatusDto status;
  final ContentTypeDto contentType;
  final List<ResourceDto> resources;

  NewsDto({
    required this.id,
    required this.title,
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
    required this.contentType,
    required this.resources,
  });

  factory NewsDto.fromJson(Map<String, dynamic> json) {
    return NewsDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      slug: json['slug'],
      publishedAt: json['published_at'],
      isFeatured: json['is_featured'],
      engagementScore: (json['engagement_score'] as num).toDouble(),
      author: AuthorDto.fromJson(json['author']),
      source: SourceDto.fromJson(json['source']),
      category: CategoryDto.fromJson(json['category']),
      tags: (json['tags'] as List)
          .map((e) => TagDto.fromJson(e))
          .toList(),
      language: LanguageDto.fromJson(json['language']),
      region: RegionDto.fromJson(json['region']),
      status: StatusDto.fromJson(json['status']),
      contentType: ContentTypeDto.fromJson(json['content_type']),
      resources: (json['resources'] as List)
          .map((e) => ResourceDto.fromJson(e))
          .toList(),
    );
  }
}
