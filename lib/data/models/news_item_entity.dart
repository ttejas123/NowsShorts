// lib/data/models/news_item_entity.dart

enum NewsLayoutType {
  photoDominant, // big image, small text
  textDominant,  // more text, image secondary
  gallery,       // horizontal image slider
  story,         // story-like full-bleed layout
  htmlViewCard,   // card with static html preview
  browserCard,   // card with link to external browser
}

class NewsItemEntity {
  final String id;
  final String title;
  final String? subtitle;
  final String? body;
  final String? imageUrl;
  final String? webUrl;
  final String? html;
  final List<String> galleryUrls;
  final String source;
  final DateTime publishedAt;
  final NewsLayoutType layoutType;

  const NewsItemEntity({
    required this.id,
    required this.title,
    required this.source,
    required this.publishedAt,
    required this.layoutType,
    this.subtitle,
    this.webUrl,
    this.html,
    this.body,
    this.imageUrl,
    this.galleryUrls = const [],
  });
}
