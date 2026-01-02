import 'package:bl_inshort/core/logging/Console.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonDecodeException implements Exception {
  final String dtoName;
  final Object error;
  final StackTrace stack;
  final Map<String, dynamic> json;

  JsonDecodeException({
    required this.dtoName,
    required this.error,
    required this.stack,
    required this.json,
  });

  @override
  String toString() {
    return '''
        ❌ JSON → DTO failed
        DTO: $dtoName
        Error: $error
        JSON:
        $json
        Stack:
        $stack
    ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonDecodeException &&
        other.dtoName == dtoName &&
        other.error == error &&
        other.stack == stack &&
        other.json == json;
  }

  @override
  int get hashCode {
    return dtoName.hashCode ^ error.hashCode ^ stack.hashCode ^ json.hashCode;
  }

  @override
  Map<String, dynamic> toJson() {
    final String loc =
        extractPathFromStackTrace(stackTrace: stack, index: 3) ?? "";
    return {'dtoName': dtoName, 'error': error, 'stack': loc, 'json': json};
  }
}

T safeFromJson<T>(dynamic json, JsonFactory<T> factory, String dtoName) {
  try {
    return factory(json as Map<String, dynamic>);
  } catch (e, s) {
    throw JsonDecodeException(dtoName: dtoName, error: e, stack: s, json: json);
  }
}
