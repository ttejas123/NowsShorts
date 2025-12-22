enum NotificationTargetType {
  feed,        // opens feed entity
  story,       // opens story viewer
  announcement,// internal page
  externalUrl, // browser
  webview,     // in-app webview
  none,        // informational only
}

enum NotificationPriority {
  max,    // heads-up + sound
  high,   // heads-up
  normal, // tray only
  low,    // silent tray
}

enum NotificationType {
  breaking,        // urgent, interruptive
  recommendation,  // personalized
  recent,          // passive updates
  announcement,    // system / product updates
  reminder,        // scheduled / nudges
  promotional,     // ads / offers
  silent,          // data sync / background
}
