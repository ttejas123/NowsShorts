// lib/features/feed/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bl_inshort/data/models/news_item_entity.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'controllers/feed_controller.dart';


const String marketingHtmlTemplate = '''
  <!doctype html>
<html lang="en">
<div style="display: flex; justify-content: center; align-items: center; height: 100vh; font-family: Arial, sans-serif;">
  <div style="font-size: 24px; color: #333;">
Hey There is this plan HTML Template
  </div>
</body>
</html>


  ''';
  
final HtmlTemplateViewProvider = Provider<String>((ref) {
  return marketingHtmlTemplate;
});

/// Static fake data provider (for now).
/// Later you can replace this with a repository that hits your API.
final allNewsProvider = Provider<List<NewsItemEntity>>((ref) {
  final now = DateTime.now();

  return [
    NewsItemEntity(
      id: '2',
      title: 'Government Announces New Start-up Incentive Policy',
      subtitle: 'Tax relaxations and grants for early-stage founders.',
      body:
          'Grammy award winning Indian composer Ricky Kej shared CCTV video of a Zomato delivery person stealing a manhole cover from his home in Bengaluru. The incident took place around 6 pm on December 11. Kej said the delivery person came in just 15 minutes earlier for a recce. Ricky sought police help and shared the suspect\'s number plate.',
      imageUrl:
          'https://images.pexels.com/photos/1181400/pexels-photo-1181400.jpeg',
      galleryUrls: [
        "https://images.unsplash.com/photo-1521737604893-d14cc237f11d",
        "https://images.unsplash.com/photo-1556761175-5973dc0f32e7",
        'https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg',
        'https://images.pexels.com/photos/1434608/pexels-photo-1434608.jpeg',
        'https://images.pexels.com/photos/3227982/pexels-photo-3227982.jpeg',
      ],
      source: 'Business Daily',
      publishedAt: now.subtract(const Duration(hours: 30)),
      layoutType: NewsLayoutType.standardCard,
    ),
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
      webUrl: 'https://tejasflutter12112.oneapp.dev/',
      layoutType: NewsLayoutType.standardCard,
    ),
    NewsItemEntity(
      id: '3',
      title: 'In Pictures: Stunning Auroras Light Up the Night Sky',
      subtitle: 'Photographers capture rare celestial views.',
      body: 'A rare geomagnetic storm created vibrant auroras visible from...',
      imageUrl: 'https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg',
      galleryUrls: [
        'https://images.pexels.com/photos/1257860/pexels-photo-1257860.jpeg',
        'https://images.pexels.com/photos/1434608/pexels-photo-1434608.jpeg',
        'https://images.pexels.com/photos/3227982/pexels-photo-3227982.jpeg',
      ],
      source: 'Space Today',
      publishedAt: now.subtract(const Duration(hours: 2)),
      layoutType: NewsLayoutType.standardCard,
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
      layoutType: NewsLayoutType.standardCard,
    ),
    // NewsItemEntity(
    //   id: 'web_1',
    //   title: 'Interactive Budget Breakdown 2025',
    //   subtitle: 'Tap to view charts, filters and details',
    //   body: null,
    //   imageUrl:
    //       'https://images.pexels.com/photos/669610/pexels-photo-669610.jpeg',
    //   source: 'ShortNews Labs',
    //   publishedAt: now.subtract(const Duration(minutes: 10)),
    //   layoutType: NewsLayoutType.browserCard,
    //   webUrl: 'https://tejasflutter12112.oneapp.dev/'
    // ),
    // NewsItemEntity(
    //   id: 'web_2',
    //   title: 'Interactive Budget Breakdown 2025',
    //   subtitle: 'Tap to view charts, filters and details',
    //   body: null,
    //   imageUrl:
    //       'https://images.pexels.com/photos/669610/pexels-photo-669610.jpeg',
    //   source: 'ShortNews Labs',
    //   publishedAt: now.subtract(const Duration(minutes: 10)),
    //   layoutType: NewsLayoutType.browserCard,
    //   webUrl: 'https://tejasflutter12113.oneapp.dev/'
    // ),
    // NewsItemEntity(
    //   id: 'web_3',
    //   title: 'Interactive Budget Breakdown 2025',
    //   subtitle: 'Tap to view charts, filters and details',
    //   body: null,
    //   imageUrl:
    //       'https://images.pexels.com/photos/669610/pexels-photo-669610.jpeg',
    //   source: 'ShortNews Labs',
    //   publishedAt: now.subtract(const Duration(minutes: 10)),
    //   layoutType: NewsLayoutType.browserCard,
    //   webUrl: 'https://tejasflutter12114.oneapp.dev/',
    // ),
    // NewsItemEntity(
    //   id: 'web_4',
    //   title: 'Interactive Budget Breakdown 2025',
    //   subtitle: 'Tap to view charts, filters and details',
    //   body: null,
    //   imageUrl:
    //       'https://images.pexels.com/photos/669610/pexels-photo-669610.jpeg',
    //   source: 'ShortNews Labs',
    //   publishedAt: now.subtract(const Duration(minutes: 10)),
    //   layoutType: NewsLayoutType.htmlViewCard,
    //   html: marketingHtmlTemplate,
    // ),
    // You can add more items or generate them later.
  ];
});

/// Feed controller provider (pagination + state management)
final feedControllerProvider =
    StateNotifierProvider<FeedController, FeedState>((ref) {
  return FeedController(ref.read);
});
