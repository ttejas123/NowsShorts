import 'package:bl_inshort/data/dto/notifications/notification_presentation_dto.dart';
import 'package:bl_inshort/data/models/feeds/resource_entity.dart';

class NotificationPresentation {
  final String title;
  final String subtitle;
  final String? body;

  /// Icons, images, thumbnails, avatars
  final List<ResourceEntity>? resources;

  /// UI hints
  final bool highlight;
  final String? badge;

  const NotificationPresentation({
    required this.title,
    required this.subtitle,
    this.body,
    this.resources,
    this.highlight = false,
    this.badge,
  });

  factory NotificationPresentation.fromDto(NotificationPresentationDTO dto) {
    return NotificationPresentation(
      title: dto.title, 
      subtitle: dto.subtitle,
      badge: dto.badge,
      body: dto.body,
      highlight: dto.highlight,
      resources: ResourceEntity.fromDtoList(dto.resources),
    );
  }
}

extension NotificationPresentationDtoX on NotificationPresentationDTO? {
  NotificationPresentation? toEntity() {
    final dto = this;
    if (dto == null) return null;

    return NotificationPresentation.fromDto(dto);
  }
}