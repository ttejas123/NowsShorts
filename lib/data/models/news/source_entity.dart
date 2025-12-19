import 'package:bl_inshort/data/dto/common/source_dto.dart';

class SourceEntity {
  final int id;
  final String name;
  final String website;

  SourceEntity({
    required this.id,
    required this.name,
    required this.website,
  });

  factory SourceEntity.fromDto(SourceDto dto) {
    return SourceEntity(
      id: dto.id,
      name: dto.name,
      website: dto.website,
    );
  }
}
