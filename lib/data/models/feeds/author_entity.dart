import 'package:bl_inshort/data/dto/common/author_dto.dart';

class AuthorEntity {
  final int id;
  final String name;
  final String bio;
  final String profilePicture;

  AuthorEntity({
    required this.id,
    required this.name,
    required this.bio,
    required this.profilePicture,
  });

  factory AuthorEntity.fromDto(AuthorDto dto) {
    return AuthorEntity(
      id: dto.id,
      name: dto.name,
      bio: dto.bio,
      profilePicture: dto.profilePicture,
    );
  }
}
