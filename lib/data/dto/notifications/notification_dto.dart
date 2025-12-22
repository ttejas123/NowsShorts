class NotificationDTO {
  final int id;
  final String title;
  final String subtitle;
  final String? body;
  final String? image_url;

  final String type;
  final String priority;

  final String target_type;
  final String? target_value;

  final bool is_read;
  final bool is_dismissible;

  final String created_at;
  final String? expires_at;

  final Map<String, dynamic>? metadata;

  NotificationDTO({
    required this.id,
    required this.title,
    required this.subtitle,
    this.body,
    this.image_url,
    required this.type,
    required this.priority,
    required this.target_type,
    this.target_value,
    required this.is_read,
    required this.is_dismissible,
    required this.created_at,
    this.expires_at,
    this.metadata,
  });

  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationDTO(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      body: json['body'],
      image_url: json['image_url'],
      type: json['type'],
      priority: json['priority'],
      target_type: json['target_type'],
      target_value: json['target_value'],
      is_read: json['is_read'],
      is_dismissible: json['is_dismissible'],
      created_at: json['created_at'],
      expires_at: json['expires_at'],
      metadata: json['metadata'],
    );
  }
}
