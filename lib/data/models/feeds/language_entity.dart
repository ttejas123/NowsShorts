import 'package:bl_inshort/data/dto/common/language_dto.dart';

class LanguageEntity {
  int? id;
  final String name;
  final String code;

  LanguageEntity({this.id, required this.name, required this.code});

  factory LanguageEntity.fromDto(LanguageDto dto) {
    return LanguageEntity(id: dto.id, name: dto.name, code: dto.code);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }
}
