import 'package:bl_inshort/data/dto/common/region_dto.dart';

class RegionEntity {
  final int id;
  final String name;
  final String code;

  RegionEntity({
    required this.id,
    required this.name,
    required this.code,
  });

  factory RegionEntity.fromDto(RegionDto dto) {
    return RegionEntity(
      id: dto.id,
      name: dto.name,
      code: dto.code,
    );
  }
}
