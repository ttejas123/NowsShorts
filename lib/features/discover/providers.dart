import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverCategory {
  final String id;
  final String label;
  final String icon; // use Icons.* via mapping, or Emoji for now

  const DiscoverCategory({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class DiscoverTopic {
  final String id;
  final String label;

  const DiscoverTopic({
    required this.id,
    required this.label,
  });
}

/// Static categories like in the screenshot:
/// My Feed, All News, Top Stories, Trending, etc.
final discoverCategoriesProvider =
    Provider<List<DiscoverCategory>>((ref) {
  return const [
    DiscoverCategory(id: 'my_feed', label: 'My Feed', icon: '⭐'),
    DiscoverCategory(id: 'all_news', label: 'All News', icon: '📰'),
    DiscoverCategory(id: 'top_stories', label: 'Top Stories', icon: '⬆️'),
    DiscoverCategory(id: 'trending', label: 'Trending', icon: '🔥'),
    DiscoverCategory(id: 'saved', label: 'Saved', icon: '🔖'),
    DiscoverCategory(id: 'india', label: 'India', icon: '🇮🇳'),
  ];
});

/// Suggested topics carousel (static for now)
final discoverTopicsProvider = Provider<List<DiscoverTopic>>((ref) {
  return const [
    DiscoverTopic(id: 'cricket_wc', label: 'Cricket World Cup'),
    DiscoverTopic(id: 'lok_sabha', label: 'Lok Sabha Elections'),
    DiscoverTopic(id: 'general_2019', label: 'General Elections'),
    DiscoverTopic(id: 'tech_startups', label: 'Startups & Tech'),
    DiscoverTopic(id: 'markets', label: 'Markets'),
    DiscoverTopic(id: 'space', label: 'Space & Science'),
  ];
});


class DiscoverNotificationItem {
  final String id;
  final String title;
  final String? imageUrl;
  final DateTime createdAt;

  const DiscoverNotificationItem({
    required this.id,
    required this.title,
    required this.createdAt,
    this.imageUrl,
  });
}

final discoverNotificationsProvider =
    Provider<List<DiscoverNotificationItem>>((ref) {
  final now = DateTime.now();

  return [
    DiscoverNotificationItem(
      id: 'n1',
      title:
          'Students record headmaster while he was kissing student in Mysuru school; sexual assault case filed',
      createdAt: now.subtract(const Duration(minutes: 12)),
      imageUrl:
          'https://images.pexels.com/photos/256417/pexels-photo-256417.jpeg',
    ),
    DiscoverNotificationItem(
      id: 'n2',
      title:
          'World no.1 Ash Barty becomes 1st Australian woman to win Australian Open singles\' title in 44 years',
      createdAt: now.subtract(const Duration(minutes: 35)),
      imageUrl:
          'https://images.pexels.com/photos/1405355/pexels-photo-1405355.jpeg',
    ),
    DiscoverNotificationItem(
      id: 'n3',
      title:
          'Kourtney Kardashian accused of photoshopping her buttocks; deletes pic from Instagram',
      createdAt: now.subtract(const Duration(hours: 1, minutes: 5)),
      imageUrl:
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg',
    ),
  ];
});
