import 'package:bl_inshort/data/dto/common/category_dto.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String description;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryEntity.fromDto(CategoryDto dto) {
    return CategoryEntity(
      id: dto.id,
      name: dto.name,
      description: dto.description,
    );
  }
}
