import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

/// Converts any object into JSON-safe structure
dynamic toEncodable(dynamic value, {Set<Object>? visited}) {
  visited ??= <Object>{};

  if (value == null || value is String || value is num || value is bool) {
    return value;
  }

  if (value is DateTime) {
    return value.toIso8601String();
  }

  if (value is Iterable) {
    return value.map((e) => toEncodable(e, visited: visited)).toList();
  }

  if (value is Map) {
    return value.map(
      (k, v) => MapEntry(k.toString(), toEncodable(v, visited: visited)),
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
  final json = const JsonEncoder.withIndent('  ').convert(encodable);

  Clipboard.setData(ClipboardData(text: json));
}

void inspectInDevTools(dynamic entity) {
  if (!kDebugMode) return;

  // Put breakpoint on next line 👇
  final inspect = toEncodable(entity);
}

void prittyPrint(dynamic entity, {String name = ''}) {
  if (!kDebugMode) return;

  final encodable = toEncodable(entity);
  final caller = _callerFileLine();
  final stack = _singleFrameStack();
  final caller2 = _callerOnlyStack();
  final json = const JsonEncoder.withIndent('    ').convert(encodable);

  developer.log(json, name: name);
  developer.log("", name: name, error: caller, stackTrace: stack);
  developer.log(json, name: name, stackTrace: _callerOnlyStack());
}

String _callerFileLine() {
  final lines = StackTrace.current.toString().split('\n');
  final line = lines.length > 2 ? lines[2].trim() : 'unknown';
  final match = RegExp(r'(\w+\.dart:\d+)').firstMatch(line);
  print(match?.group(0));
  return match?.group(0) ?? 'unknown';
}

StackTrace _callerOnlyStack() {
  final lines = StackTrace.current.toString().split('\n');

  // Stack layout:
  // 0 = StackTrace.current
  // 1 = _callerOnlyStack
  // 2 = prettyPrint
  // 3 = 👈 actual caller
  final callerFrame = lines.length > 2 ? lines[2] : lines.last;

  return StackTrace.fromString(callerFrame);
}

// String _callerFileLine() {
//   final lines = StackTrace.current.toString().split('\n');

//   // 0 = StackTrace.current
//   // 1 = _callerFileLine
//   // 2 = prettyPrint
//   // 3 = 👈 actual caller
//   return lines.length > 2 ? lines[2].trim() : 'unknown';
// }

StackTrace _singleFrameStack() {
  final lines = StackTrace.current.toString().split('\n');

  // 0 StackTrace.current
  // 1 _singleFrameStack
  // 2 prettyPrint
  // 3 👈 actual caller
  final caller = lines.length > 2 ? lines[2] : lines.last;

  return StackTrace.fromString(caller);
}
