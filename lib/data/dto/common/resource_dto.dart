import 'dart:math';

import 'package:bl_inshort/data/dto/common/content_type_dto.dart';
import 'package:bl_inshort/data/models/feeds/resource_entity.dart';

class ResourceDto {
  final int id;
  final String name;
  final String url;
  final ContentTypeDto contentType;

  ResourceDto({
    this.id = 0,
    required this.name,
    required this.url,
    required this.contentType,
  });

  factory ResourceDto.fromJson(Map<String, dynamic> json) {
    return ResourceDto(
      id: json['id'] ?? Random().nextInt(1000000),
      name: json['name'],
      url: json['url'],
      contentType: ContentTypeDto.fromJson(json['content_type']),
    );
  }

  @override
  String toString() {
    return 'ResourceDto{id=$id, name=$name, url=$url, contentType=$contentType}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'content_type': contentType.toJson(),
    };
  }

  ResourceEntity toEntity() {
    return ResourceEntity(
      id: id,
      name: name,
      url: url,
      contentType: contentType.toEntity(),
    );
  }
}
