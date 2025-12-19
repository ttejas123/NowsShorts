import 'package:bl_inshort/data/dto/common/status_dto.dart';

class StatusEntity {
  final int id;
  final String name;
  final String description;

  StatusEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory StatusEntity.fromDto(StatusDto dto) {
    return StatusEntity(
      id: dto.id,
      name: dto.name,
      description: dto.description,
    );
  }
}
