import 'package:bl_inshort/data/dto/common/Item_type_provider_dto.dart';
import 'package:bl_inshort/data/dto/feed/feed_dto.dart';

class ItemTypeProvider {
  final String name;
  final ItemType type;
  final String subType;
  final String id;

  ItemTypeProvider({
    required this.name,
    required this.type,
    required this.subType,
    required this.id,
  });

  factory ItemTypeProvider.fromDto(ItemTypeProviderDto dto) {
    return ItemTypeProvider(
      name: dto.name,
      type: dto.type,
      subType: dto.subType,
      id: dto.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type.name, 'subType': subType, 'id': id};
  }

  ItemTypeProvider copyWith({
    String? name,
    ItemType? type,
    String? subType,
    String? id,
  }) {
    return ItemTypeProvider(
      name: name ?? this.name,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'ItemTypeProvider{name: $name, type: $type, subType: $subType, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemTypeProvider &&
        other.name == name &&
        other.type == type &&
        other.subType == subType &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ subType.hashCode ^ id.hashCode;
  }
}
