import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';
import 'package:bl_inshort/data/models/notifications/notification_state.dart';

class NotificationStateDTO extends FactorySafeDto<NotificationStateDTO> {
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

  NotificationStateDTO fromJson(Map<String, dynamic> json) {
    return NotificationStateDTO(
      isRead: json['isRead'] ?? false,
      isDismissed: json['isDismissed'] ?? false,
      delivered: json['delivered'] ?? false,
      opened: json['opened'] ?? false,
    );
  }

  factory NotificationStateDTO.prototype() {
    return NotificationStateDTO(
      isRead: false,
      isDismissed: false,
      delivered: false,
      opened: false,
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

  NotificationState toEntity() {
    return NotificationState(
      isRead: isRead,
      isDismissed: isDismissed,
      delivered: delivered,
      opened: opened,
    );
  }
}
