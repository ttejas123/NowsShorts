import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';
import 'package:bl_inshort/data/models/feeds/source_entity.dart';

class SourceDto extends FactorySafeDto<SourceDto> {
  final int id;
  final String name;
  final String website;

  SourceDto({required this.id, required this.name, required this.website});

  SourceDto fromJson(Map<String, dynamic> json) {
    return SourceDto(
      id: json['id'],
      name: json['name'],
      website: json['website'],
    );
  }

  factory SourceDto.prototype() {
    return SourceDto(id: -1, name: "", website: "");
  }

  @override
  String toString() {
    return 'SourceDto{id=$id, name=$name, website=$website}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'website': website};
  }

  SourceEntity toEntity() {
    return SourceEntity(id: id, name: name, website: website);
  }
}
