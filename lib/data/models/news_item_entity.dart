// lib/data/models/news_item_entity.dart

enum NewsLayoutType {
  photoDominant, // big image, small text
  textDominant,  // more text, image secondary
  gallery,       // horizontal image slider
  story,         // story-like full-bleed layout
}

class NewsItemEntity {
  final String id;
  final String title;
  final String? subtitle;
  final String? body;
  final String? imageUrl;
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
    this.body,
    this.imageUrl,
    this.galleryUrls = const [],
  });
}
