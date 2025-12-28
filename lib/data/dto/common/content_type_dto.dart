import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';
import 'package:bl_inshort/data/models/feeds/content_type_entity.dart';

class ContentTypeDto extends FactorySafeDto<ContentTypeDto> {
  final int id;
  final String name;
  final String description;

  ContentTypeDto({
    required this.id,
    required this.name,
    required this.description,
  });

  ContentTypeDto fromJson(Map<String, dynamic> json) {
    return ContentTypeDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  factory ContentTypeDto.prototype() {
    return ContentTypeDto(id: -1, name: "", description: "");
  }

  @override
  String toString() {
    return 'ContentTypeDto{id=$id, name=$name, description=$description}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  ContentTypeEntity toEntity() {
    return ContentTypeEntity(id: id, name: name, description: description);
  }
}
