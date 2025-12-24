enum NotificationTargetType {
  feed,        // opens feed entity
  story,       // opens story viewer
  announcement,// internal page
  externalUrl, // browser
  webview,     // in-app webview
  none;        // informational only

  static NotificationTargetType fromString(String value) {
    return NotificationTargetType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationTargetType.none,
    );
  }
}

enum NotificationPriority {
  max,    // heads-up + sound
  high,   // heads-up
  normal, // tray only
  low;    // silent tray

  static NotificationPriority fromString(String value) {
    return NotificationPriority.values.firstWhere(
      (e)=> e.name == value,
      orElse: () => NotificationPriority.normal,
    );
  }
}

enum NotificationType {
  breaking,        // urgent, interruptive
  recommendation,  // personalized
  recent,          // passive updates
  announcement,    // system / product updates
  reminder,        // scheduled / nudges
  promotional,     // ads / offers
  silent;          // data sync / background

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (e)=> e.name == value,
      orElse: () => NotificationType.silent,
    );
  }
}

enum NotificationIntent {
  breaking,
  recommendation,
  reminder,
  announcement,
  promotion,
  engagement,
  silent;

  static NotificationIntent fromString(String value) {
    return NotificationIntent.values.firstWhere(
      (e)=> e.name == value,
      orElse: () => NotificationIntent.silent,
    );
  }

}
