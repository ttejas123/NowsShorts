import 'package:bl_inshort/data/dto/common/resource_dto.dart';
import 'package:bl_inshort/data/models/feeds/content_type_entity.dart';

class ResourceEntity {
  final int id;
  final String name;
  final String url;
  final ContentTypeEntity contentType;

  ResourceEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.contentType,
  });

  factory ResourceEntity.fromDto(ResourceDto dto) {
    return ResourceEntity(
      id: dto.id,
      name: dto.name,
      url: dto.url,
      contentType: ContentTypeEntity.fromDto(dto.contentType),
    );
  }

  static List<ResourceEntity> fromDtoList(List<ResourceDto> dtoList) {
    return dtoList.map((dto) => ResourceEntity.fromDto(dto)).toList();
  }
}
