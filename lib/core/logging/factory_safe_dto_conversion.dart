import 'package:bl_inshort/core/logging/json_decode_exception.dart';

class FactorySafeDto<T> {
  T decode(Map<String, dynamic> json) {
    return safeFromJson<T>(
      json,
      (this as dynamic).fromJson,
      runtimeType.toString(),
    );
  }
}
