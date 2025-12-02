// lib/features/feed/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bl_inshort/data/models/news_item_entity.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'controllers/feed_controller.dart';

/// Static fake data provider (for now).
/// Later you can replace this with a repository that hits your API.
final allNewsProvider = Provider<List<NewsItemEntity>>((ref) {
  final now = DateTime.now();

  return [
    NewsItemEntity(
      id: '1',
      title: 'Massive Monsoon Rains Lash the City, Traffic Disrupted',
      subtitle: 'Commuters face long jams as key roads are waterlogged.',
      body:
          'Heavy rainfall continued through the night, causing severe waterlogging in major parts of the city. Officials have urged citizens to avoid non-essential travel...',
      imageUrl:
          'https://images.pexels.com/photos/1105766/pexels-photo-1105766.jpeg',
      source: 'City News',
      publishedAt: now.subtract(const Duration(minutes: 5)),
      layoutType: NewsLayoutType.photoDominant,
    ),
    NewsItemEntity(
      id: '2',
      title: 'Government Announces New Start-up Incentive Policy',
      subtitle: 'Tax relaxations and grants for early-stage founders.',
      body:
          'The new policy aims to boost innovation and entrepreneurship by offering tax relaxations, faster compliance clearance, and grants for early-stage startups...',
      imageUrl:
          'https://images.pexels.com/photos/1181400/pexels-photo-1181400.jpeg',
      source: 'Business Daily',
      publishedAt: now.subtract(const Duration(minutes: 30)),
      layoutType: NewsLayoutType.textDominant,
    ),
    NewsItemEntity(
      id: '3',
      title: 'In Pictures: Stunning Auroras Light Up the Night Sky',
      subtitle: 'Photographers capture rare celestial views.',
      body: 'A rare geomagnetic storm created vibrant auroras visible from...',
      imageUrl: null,
      galleryUrls: [
        'https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg',
        'https://images.pexels.com/photos/1434608/pexels-photo-1434608.jpeg',
        'https://images.pexels.com/photos/3227982/pexels-photo-3227982.jpeg',
      ],
      source: 'Space Today',
      publishedAt: now.subtract(const Duration(hours: 2)),
      layoutType: NewsLayoutType.gallery,
    ),
    NewsItemEntity(
      id: '4',
      title: 'Opinion: Why Slow Living Is the New Hustle',
      body:
          'The culture of always being “on” is breaking people. A new wave of creators and professionals is embracing slow living as a way to regain focus and joy...',
      imageUrl:
          'https://images.pexels.com/photos/713312/pexels-photo-713312.jpeg',
      source: 'Lifestyle Weekly',
      publishedAt: now.subtract(const Duration(hours: 3)),
      layoutType: NewsLayoutType.story,
    ),
    // You can add more items or generate them later.
  ];
});

/// Feed controller provider (pagination + state management)
final feedControllerProvider =
    StateNotifierProvider<FeedController, FeedState>((ref) {
  return FeedController(ref.read);
});
