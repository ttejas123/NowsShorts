class LanguageDto {
  final int id;
  final String name;
  final String code;

  LanguageDto({
    required this.id,
    required this.name,
    required this.code,
  });

  factory LanguageDto.fromJson(Map<String, dynamic> json) {
    return LanguageDto(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}
