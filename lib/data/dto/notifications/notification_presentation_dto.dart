import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';
import 'package:bl_inshort/data/models/notifications/notification_presentation.dart';

import '../common/resource_dto.dart';

class NotificationPresentationDTO
    extends FactorySafeDto<NotificationPresentationDTO> {
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

  NotificationPresentationDTO fromJson(Map<String, dynamic> json) {
    return NotificationPresentationDTO(
      title: json['title'],
      subtitle: json['subtitle'],
      body: json['body'],
      resources: json['resources'] != null
          ? (json['resources'] as List)
                .map((e) => ResourceDto.prototype().decode(e))
                .toList()
          : [],
      highlight: json['highlight'] ?? false,
      badge: json['badge'],
    );
  }

  factory NotificationPresentationDTO.prototype() {
    return NotificationPresentationDTO(
      title: "",
      subtitle: "",
      body: "",
      resources: [],
      highlight: false,
      badge: "",
    );
  }

  @override
  String toString() {
    return 'NotificationPresentationDTO{title=$title, subtitle=$subtitle, body=$body, resources=$resources, highlight=$highlight, badge=$badge}';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'body': body,
      'resources': resources.map((e) => e.toJson()).toList(),
      'highlight': highlight,
      'badge': badge,
    };
  }

  NotificationPresentation toEntity() {
    return NotificationPresentation(
      title: title,
      subtitle: subtitle,
      body: body,
      resources: resources.map((e) => e.toEntity()).toList(),
      highlight: highlight,
      badge: badge,
    );
  }
}
