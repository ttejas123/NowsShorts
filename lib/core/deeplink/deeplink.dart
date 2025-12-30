import 'package:bl_inshort/core/logging/factory_safe_dto_conversion.dart';

class DeepLink extends FactorySafeDto<DeepLink> {
  final List<String> segments;
  final Map<String, String> query;

  DeepLink({required this.segments, required this.query});

  @override
  String toString() {
    return 'DeepLink{segments: $segments, query: $query}';
  }

  Map<String, dynamic> toJson() => {'segments': segments, 'query': query};

  DeepLink fromJson(Map<String, dynamic> json) => DeepLink(
    segments: List<String>.from(json['segments']),
    query: Map<String, String>.from(json['query']),
  );

  factory DeepLink.prototype() => DeepLink(segments: [], query: {});

  factory DeepLink.fromUri(Uri uri) {
    final segments = uri.pathSegments.toList();
    final query = uri.queryParameters;
    return DeepLink(segments: segments, query: query);
  }
}
