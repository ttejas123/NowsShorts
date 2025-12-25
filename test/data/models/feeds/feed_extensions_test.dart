import 'package:flutter_test/flutter_test.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:bl_inshort/data/models/feeds/author_entity.dart';
import 'package:bl_inshort/data/models/feeds/source_entity.dart';
import 'package:bl_inshort/data/models/feeds/category_entity.dart';
import 'package:bl_inshort/data/models/feeds/tag_entity.dart';
import 'package:bl_inshort/data/models/feeds/language_entity.dart';
import 'package:bl_inshort/data/models/feeds/region_entity.dart';
import 'package:bl_inshort/data/models/feeds/status_entity.dart';
import 'package:bl_inshort/data/models/feeds/content_type_entity.dart';
import 'package:bl_inshort/data/models/feeds/resource_entity.dart';
import 'package:bl_inshort/data/dto/feed/feed_dto.dart';
import 'package:bl_inshort/data/models/feeds/_common_feed_extensions.dart';

void main() {
  group('Entity Extensions Tests', () {
    test('AuthorEntity extensions', () {
      final author = AuthorEntity(
        id: 1,
        name: 'Test Author',
        bio: 'Test Bio',
        profilePicture: 'https://example.com/pic.jpg',
      );

      expect(author.toStringPrint(), contains('Test Author'));

      final json = author.toJsonPrint();
      expect(json['id'], 1);
      expect(json['name'], 'Test Author');
      expect(json['bio'], 'Test Bio');
      expect(json['profilePicture'], 'https://example.com/pic.jpg');

      expect(author.toHashPrint(), isA<int>());
    });

    test('TagEntity extensions', () {
      final tag = TagEntity(id: 10, name: 'News');
      expect(tag.toStringPrint(), contains('News'));
      expect(tag.toJsonPrint()['name'], 'News');
      expect(tag.toHashPrint(), isA<int>());
    });

    test('FeedEntity extensions', () {
      // Mocking nested entities
      final author = AuthorEntity(
        id: 1,
        name: 'A',
        bio: 'B',
        profilePicture: 'P',
      );
      final source = SourceEntity(id: 1, name: 'S', website: 'W');
      final category = CategoryEntity(id: 1, name: 'C', description: 'D');
      final language = LanguageEntity(id: 1, name: 'L', code: 'en');
      final region = RegionEntity(id: 1, name: 'R', code: 'US');
      final status = StatusEntity(id: 1, name: 'St', description: 'Des');
      final contentType = ContentTypeEntity(
        id: 1,
        name: 'CT',
        description: 'Desc',
      );
      final resource = ResourceEntity(
        id: 1,
        name: 'Res',
        url: 'U',
        contentType: contentType,
      );

      final feed = FeedEntity(
        id: 100,
        type: ItemType.News,
        title: 'Title',
        subtitle: 'Subtitle',
        description: 'Desc',
        publishedAt: DateTime(2023, 1, 1),
        slug: 'slug',
        author: author,
        source: source,
        category: category,
        tags: [TagEntity(id: 1, name: 'T')],
        language: language,
        region: region,
        status: status,
        isFeatured: true,
        engagementScore: 4.5,
        resources: [resource],
        layout: FeedLayoutType.standardCard,
        webUrl: 'http://web',
        html: '<html>',
      );

      expect(feed.toStringPrint(), contains('Title'));

      final json = feed.toJsonPrint();
      expect(json['id'], 100);
      expect(json['title'], 'Title');
      expect(json['author'], isNotNull);
      expect(json['author']['name'], 'A');
      expect(json['resources'], isNotEmpty);
      expect(json['resources'][0]['contentType']['name'], 'CT');

      expect(feed.toHashPrint(), isA<int>());
    });
  });
}
