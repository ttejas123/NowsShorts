enum NotificationTargetType {
  feed, // opens feed entity
  story, // opens story viewer
  announcement, // internal page
  externalUrl, // browser
  webview, // in-app webview
  none; // informational only

  static const Map<String, NotificationTargetType> _map = {
    'feed': feed,
    'story': story,
    'announcement': announcement,
    'externalurl': externalUrl,
    'external_url': externalUrl,
    'webview': webview,
    'none': none,
  };

  static NotificationTargetType fromString(String? value) {
    if (value == null) return none;
    return _map[value.toLowerCase()] ?? none;
  }
}

enum NotificationPriority {
  max, // heads-up + sound
  high, // heads-up
  normal, // tray only
  low; // silent tray

  static const Map<String, NotificationPriority> _map = {
    'max': max,
    'high': high,
    'normal': normal,
    'low': low,
  };

  static NotificationPriority fromString(String value) {
    return _map[value] ?? max;
  }
}

enum NotificationType {
  breaking, // urgent, interruptive
  recommendation, // personalized
  recent, // passive updates
  announcement, // system / product updates
  reminder, // scheduled / nudges
  promotional, // ads / offers
  silent; // data sync / background

  static const Map<String, NotificationType> _map = {
    'breaking': breaking,
    'recommendation': recommendation,
    'recent': recent,
    'announcement': announcement,
    'reminder': reminder,
    'promotional': promotional,
    'silent': silent,
  };

  static NotificationType fromString(String value) {
    return _map[value] ?? silent;
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

  static const Map<String, NotificationIntent> _map = {
    'breaking': breaking,
    'recommendation': recommendation,
    'reminder': reminder,
    'announcement': announcement,
    'promotion': promotion,
    'engagement': engagement,
    'silent': silent,
  };

  static NotificationIntent fromString(String value) {
    return _map[value] ?? silent;
  }
}
