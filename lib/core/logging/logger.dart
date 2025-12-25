import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Converts any object into JSON-safe structure
dynamic toEncodable(
  dynamic value, {
  Set<Object>? visited,
}) {
  visited ??= <Object>{};

  if (value == null ||
      value is String ||
      value is num ||
      value is bool) {
    return value;
  }

  if (value is DateTime) {
    return value.toIso8601String();
  }

  if (value is Iterable) {
    return value
        .map((e) => toEncodable(e, visited: visited))
        .toList();
  }

  if (value is Map) {
    return value.map(
      (k, v) => MapEntry(
        k.toString(),
        toEncodable(v, visited: visited),
      ),
    );
  }

  // Prevent infinite recursion (circular refs)
  if (visited.contains(value)) {
    return '<circular:${value.runtimeType}>';
  }
  visited.add(value);

  // Try toJson()
  try {
    final json = (value as dynamic).toJson();
    return toEncodable(json, visited: visited);
  } catch (_) {}

  // Fallback
  return value.toString();
}

/// Copies pretty JSON to clipboard (DEBUG ONLY)
void copyJsonToClipboard(dynamic entity) {
  if (!kDebugMode) return;

  final encodable = toEncodable(entity);
  final json =
      const JsonEncoder.withIndent('  ').convert(encodable);

  Clipboard.setData(ClipboardData(text: json));
}

void inspectInDevTools(dynamic entity) {
  if (!kDebugMode) return;

  // This sends the object to DevTools Inspector
  debugPrint(
    '🔍 Inspect this object in DevTools → Debugger → Variables',
  );

  // Put breakpoint on next line 👇
  final inspect = toEncodable(entity);
}
