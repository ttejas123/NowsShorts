import 'package:bl_inshort/data/models/feeds/content_type_entity.dart';

class ContentTypeDto {
  final int id;
  final String name;
  final String description;

  ContentTypeDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ContentTypeDto.fromJson(Map<String, dynamic> json) {
    return ContentTypeDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
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
