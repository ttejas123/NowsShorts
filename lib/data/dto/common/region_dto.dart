import 'package:bl_inshort/data/models/feeds/region_entity.dart';

class RegionDto {
  final int id;
  final String name;
  final String code;

  RegionDto({required this.id, required this.name, required this.code});

  factory RegionDto.fromJson(Map<String, dynamic> json) {
    return RegionDto(id: json['id'], name: json['name'], code: json['code']);
  }

  @override
  String toString() {
    return 'RegionDto{id=$id, name=$name, code=$code}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }

  RegionEntity toEntity() {
    return RegionEntity(id: id, name: name, code: code);
  }
}
