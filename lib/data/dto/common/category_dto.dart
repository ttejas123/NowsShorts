import 'package:bl_inshort/data/models/feeds/category_entity.dart';

class CategoryDto {
  final int id;
  final String name;
  final String description;

  CategoryDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'CategoryDto{id=$id, name=$name, description=$description}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, description: description);
  }
}
