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
}
