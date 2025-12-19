class StatusDto {
  final int id;
  final String name;
  final String description;

  StatusDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory StatusDto.fromJson(Map<String, dynamic> json) {
    return StatusDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
