import 'package:bl_inshort/data/dto/common/content_type_dto.dart';

class ContentTypeEntity {
  final int id;
  final String name;
  final String description;

  ContentTypeEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ContentTypeEntity.fromDto(ContentTypeDto dto) {
    return ContentTypeEntity(
      id: dto.id,
      name: dto.name,
      description: dto.description,
    );
  }
}
