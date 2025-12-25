class NotificationStateDTO {
  final bool isRead;
  final bool isDismissed;
  final bool delivered;
  final bool opened;

  NotificationStateDTO({
    required this.isRead,
    required this.isDismissed,
    required this.delivered,
    required this.opened,
  });

  factory NotificationStateDTO.fromJson(Map<String, dynamic> json) {
    return NotificationStateDTO(
      isRead: json['isRead'] ?? false,
      isDismissed: json['isDismissed'] ?? false,
      delivered: json['delivered'] ?? false,
      opened: json['opened'] ?? false,
    );
  }

  @override
  String toString() {
    return 'NotificationStateDTO{isRead=$isRead, isDismissed=$isDismissed, delivered=$delivered, opened=$opened}';
  }

  Map<String, dynamic> toJson() {
    return {
      'isRead': isRead,
      'isDismissed': isDismissed,
      'delivered': delivered,
      'opened': opened,
    };
  }
}
