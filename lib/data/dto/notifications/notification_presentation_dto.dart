import '../common/resource_dto.dart';

class NotificationPresentationDTO {
  final String title;
  final String subtitle;
  final String? body;

  /// images / icons / avatars
  final List<ResourceDto> resources;

  /// UI hints
  final bool highlight;
  final String? badge;

  NotificationPresentationDTO({
    required this.title,
    required this.subtitle,
    this.body,
    required this.resources,
    required this.highlight,
    this.badge,
  });

  factory NotificationPresentationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationPresentationDTO(
      title: json['title'],
      subtitle: json['subtitle'],
      body: json['body'],
      resources: json['resources'] != null
          ? (json['resources'] as List)
              .map((e) => ResourceDto.fromJson(e))
              .toList()
          : [],
      highlight: json['highlight'] ?? false,
      badge: json['badge'],
    );
  }
}
