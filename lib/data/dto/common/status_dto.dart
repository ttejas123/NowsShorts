import 'package:bl_inshort/data/models/feeds/status_entity.dart';

class StatusDto {
  final int id;
  final String name;
  final String description;

  StatusDto({required this.id, required this.name, required this.description});

  StatusDto fromJson(Map<String, dynamic> json) {
    return StatusDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  factory StatusDto.prototype() {
    return StatusDto(id: -1, name: "", description: "");
  }

  @override
  String toString() {
    return 'StatusDto{id=$id, name=$name, description=$description}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  StatusEntity toEntity() {
    return StatusEntity(id: id, name: name, description: description);
  }
}
