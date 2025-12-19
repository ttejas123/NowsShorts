class TagDto {
  final int id;
  final String name;

  TagDto({
    required this.id,
    required this.name,
  });

  factory TagDto.fromJson(Map<String, dynamic> json) {
    return TagDto(
      id: json['id'],
      name: json['name'],
    );
  }
}
