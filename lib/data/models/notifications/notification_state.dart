import 'package:bl_inshort/data/dto/notifications/notification_state_dto.dart';

class NotificationState {
  final bool isRead;
  final bool isDismissed;

  /// push delivered? opened?
  final bool delivered;
  final bool opened;

  const NotificationState({
    required this.isRead,
    required this.isDismissed,
    required this.delivered,
    required this.opened,
  });

  factory NotificationState.fromDto(NotificationStateDTO dto) {
    return NotificationState(
      delivered: dto.delivered,
      isDismissed: dto.isDismissed,
      isRead: dto.isRead,
      opened: dto.opened
    );
  }
}
