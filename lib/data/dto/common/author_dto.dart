class AuthorDto {
  final int id;
  final String name;
  final String bio;
  final String profilePicture;

  AuthorDto({
    required this.id,
    required this.name,
    required this.bio,
    required this.profilePicture,
  });

  factory AuthorDto.fromJson(Map<String, dynamic> json) {
    return AuthorDto(
      bio: json['bio'],
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture']
    );
  }
}
