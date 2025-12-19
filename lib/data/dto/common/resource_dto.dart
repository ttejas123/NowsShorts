class ResourceDto {
  final int id;
  final String name;
  final String url;

  ResourceDto({
    required this.id,
    required this.name,
    required this.url,
  });

  factory ResourceDto.fromJson(Map<String, dynamic> json) {
    return ResourceDto(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}
