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
