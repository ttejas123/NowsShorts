import 'package:bl_inshort/data/models/settings/language_entity.dart';

class LanguageDTO {
  final String code;
  final String label;

  const LanguageDTO({
    required this.code,
    required this.label,
  });

  LanguageEntity toEntity() {
    return LanguageEntity(code: code, label: label);
  }

  factory LanguageDTO.fromEntity(LanguageEntity entity) {
    return LanguageDTO(
      code: entity.code,
      label: entity.label,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'label': label,
      };

  factory LanguageDTO.fromJson(Map<String, dynamic> json) {
    return LanguageDTO(
      code: json['code'],
      label: json['label'],
    );
  }
}
