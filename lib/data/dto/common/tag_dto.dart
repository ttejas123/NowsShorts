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

  @override
  String toString() {
    return 'TagDto{id=$id, name=$name}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
