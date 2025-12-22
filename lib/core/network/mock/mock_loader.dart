import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadFeedMockJson() async {
  final jsonString = await rootBundle.loadString(
    'lib/core/network/mock/responses/feed_mock.json',
  );

  return json.decode(jsonString) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> loadNotificationMockJson() async {
  final jsonString = await rootBundle.loadString(
    'lib/core/network/mock/responses/notification_mock.json',
  );

  return json.decode(jsonString) as Map<String, dynamic>;
}