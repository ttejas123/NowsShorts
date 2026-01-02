library console;

import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// JS-like global console object
final console = _Console();

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

String formatLogMessage(dynamic? input) {
  if (input == null) return 'null';

  if (input is String) return input;
  if (input is int) return input.toString();
  if (input is double) return input.toString();
  if (input is bool) return input.toString();
  if (input is DateTime) return input.toIso8601String();

  final encodable = toEncodable(input);
  final json = const JsonEncoder.withIndent('    ').convert(encodable);
  return json;
}

enum LogType { log, info, warn, error, success, debug }

class LogColors {
  static const reset = '\x1B[0m';
  static const gray = '\x1B[90m';
  static const blue = '\x1B[34m';
  static const yellow = '\x1B[33m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const purple = '\x1B[35m';
}

class DevLog {
  static LogEntry log(dynamic message, {LogType type = LogType.log}) {
    String colorizeMultiline(String text, String color) {
      const reset = '\x1B[0m';

      return text.split('\n').map((line) => '$color$line$reset').join('\n');
    }

    assert(() {
      final color = _colorFor(type);
      final name = _callerFileLine();
      developer.log(
        colorizeMultiline(formatLogMessage(message), color),
        name: name,
      );
      print('${extractPathFromStackTrace()}');

      return true;
    }());

    return LogEntry((message != null) ? '$message' : '');
  }

  static String _colorFor(LogType type) {
    switch (type) {
      case LogType.log:
        return LogColors.gray;
      case LogType.info:
        return LogColors.blue;
      case LogType.warn:
        return LogColors.yellow;
      case LogType.error:
        return LogColors.red;
      case LogType.success:
        return LogColors.green;
      case LogType.debug:
        return LogColors.purple;
    }
  }
}

class LogEntry {
  final String message;

  LogEntry(this.message);

  /// Copy log content to clipboard
  void copy() {
    // Clipboard.setData(ClipboardData(text: message));
  }

  /// Optional helpers
  void printAgain() {
    debugPrint(message);
  }
}

class _Console {
  void log(dynamic msg) {
    DevLog.log(msg, type: LogType.log);
  }

  void info(dynamic msg) => DevLog.log(msg, type: LogType.info);

  void warn(dynamic msg) => DevLog.log(msg, type: LogType.warn);

  void error(dynamic msg) => DevLog.log(msg, type: LogType.error);

  void success(dynamic msg) => DevLog.log(msg, type: LogType.success);

  void debug(dynamic msg) => DevLog.log(msg, type: LogType.debug);
}

String _callerFileLine() {
  final lines = StackTrace.current.toString().split('\n');
  final line = lines.length > 4 ? lines[4].trim() : 'unknown';
  final match = RegExp(r'(\w+\.dart:\d+)').firstMatch(line);
  return match?.group(0) ?? 'unknown';
}

String? extractPathFromStackTrace({StackTrace? stackTrace, int index = 4}) {
  final trace = (stackTrace ?? StackTrace.current).toString();
  final lines = trace.split('\n');

  if (index < 0 || index >= lines.length) {
    return 'null';
  }

  final line = lines[index];

  // Match: (package:xxx/yyy.dart:line:column)
  final match = RegExp(r'\((package:[^)]+)\)').firstMatch(line);

  if (match == null || match.groupCount < 1) {
    return 'null';
  }

  return match.group(1);
}
