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

  @override
  String toString() {
    return 'SourceDto{id=$id, name=$name, website=$website}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'website': website,
    };
  }
}
