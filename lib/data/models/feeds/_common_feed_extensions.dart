import 'package:bl_inshort/data/models/feeds/author_entity.dart';
import 'package:bl_inshort/data/models/feeds/category_entity.dart';
import 'package:bl_inshort/data/models/feeds/content_type_entity.dart';
import 'package:bl_inshort/data/models/feeds/feed_entity.dart';
import 'package:bl_inshort/data/models/feeds/language_entity.dart';
import 'package:bl_inshort/data/models/feeds/region_entity.dart';
import 'package:bl_inshort/data/models/feeds/source_entity.dart';
import 'package:bl_inshort/data/models/feeds/status_entity.dart';
import 'package:bl_inshort/data/models/feeds/tag_entity.dart';
import 'package:bl_inshort/data/models/feeds/resource_entity.dart';

/*
  TODO: toString(), toJson() and toHash() methods 
  And we have to rename this function as  
      1) toString = toStringPrint 
      2) toJson = toJsonPrint 
      3) toHash = toHashPrint
*/

extension FeedEntityExtension on FeedEntity {
  String toStringPrint() {
    return 'FeedEntity(id: $id, title: $title, type: $type)';
  }

  Map<String, dynamic> toJsonPrint() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'publishedAt': publishedAt.toIso8601String(),
      'slug': slug,
      'webUrl': webUrl,
      'html': html,
      'author': author.toJsonPrint(),
      'source': source.toJsonPrint(),
      'category': category.toJsonPrint(),
      'tags': tags.map((e) => e.toJsonPrint()).toList(),
      'language': language.toJsonPrint(),
      'region': region.toJsonPrint(),
      'layout': layout.toString(),
      'status': status.toJsonPrint(),
      'type': type.toString(),
      'isFeatured': isFeatured,
      'engagementScore': engagementScore,
      'resources': resources.map((e) => e.toJsonPrint()).toList(),
    };
  }
}

extension AuthorEntityExtension on AuthorEntity {
  String toStringPrint() => 'AuthorEntity(id: $id, name: $name)';

  Map<String, dynamic> toJsonPrint() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profilePicture': profilePicture,
    };
  }
}

extension LanguageEntityExtension on LanguageEntity {
  String toStringPrint() => 'LanguageEntity(id: $id, name: $name, code: $code)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name, 'code': code};
  }
}

extension CategoryEntityExtension on CategoryEntity {
  String toStringPrint() => 'CategoryEntity(id: $id, name: $name)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension SourceEntityExtension on SourceEntity {
  String toStringPrint() => 'SourceEntity(id: $id, name: $name)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name, 'website': website};
  }
}

extension ContentTypeEntityExtension on ContentTypeEntity {
  String toStringPrint() => 'ContentTypeEntity(id: $id, name: $name)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension RegionEntityExtension on RegionEntity {
  String toStringPrint() => 'RegionEntity(id: $id, name: $name, code: $code)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name, 'code': code};
  }
}

extension StatusEntityExtension on StatusEntity {
  String toStringPrint() => 'StatusEntity(id: $id, name: $name)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension TagEntityExtension on TagEntity {
  String toStringPrint() => 'TagEntity(id: $id, name: $name)';

  Map<String, dynamic> toJsonPrint() {
    return {'id': id, 'name': name};
  }
}

extension ResourceEntityExtension on ResourceEntity {
  String toStringPrint() => 'ResourceEntity(id: $id, name: $name, url: $url)';

  Map<String, dynamic> toJsonPrint() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'contentType': contentType
          .toJsonPrint(), // Note: contentType needs extension too
    };
  }
}
