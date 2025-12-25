import 'package:bl_inshort/data/models/feeds/language_entity.dart';

class LanguageDto {
  final int id;
  final String name;
  final String code;

  LanguageDto({required this.id, required this.name, required this.code});

  factory LanguageDto.fromJson(Map<String, dynamic> json) {
    return LanguageDto(id: json['id'], name: json['name'], code: json['code']);
  }

  @override
  String toString() {
    return 'LanguageDto{id=$id, name=$name, code=$code}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }

  LanguageEntity toEntity() {
    return LanguageEntity(id: id, name: name, code: code);
  }
}
