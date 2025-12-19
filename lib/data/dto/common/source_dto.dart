class SourceDto {
  final int id;
  final String name;
  final String website;

  SourceDto({
    required this.id,
    required this.name,
    required this.website,
  });

  factory SourceDto.fromJson(Map<String, dynamic> json) {
    return SourceDto(
      id: json['id'],
      name: json['name'],
      website: json['website'],
    );
  }
}
