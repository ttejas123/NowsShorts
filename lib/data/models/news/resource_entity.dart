import 'package:bl_inshort/data/dto/common/resource_dto.dart';

class ResourceEntity {
  final int id;
  final String name;
  final String url;

  ResourceEntity({
    required this.id,
    required this.name,
    required this.url,
  });

  factory ResourceEntity.fromDto(ResourceDto dto) {
    return ResourceEntity(
      id: dto.id,
      name: dto.name,
      url: dto.url,
    );
  }
}
