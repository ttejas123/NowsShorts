import 'package:bl_inshort/data/models/feeds/author_entity.dart';

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
      profilePicture: json['profile_picture'],
    );
  }

  @override
  String toString() {
    return 'AuthorDto{id=$id, name=$name, bio=$bio, profilePicture=$profilePicture}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profile_picture': profilePicture,
    };
  }

  AuthorEntity toEntity() {
    return AuthorEntity(
      id: id,
      name: name,
      bio: bio,
      profilePicture: profilePicture,
    );
  }
}
