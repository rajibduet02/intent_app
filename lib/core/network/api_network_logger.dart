import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Pretty, terminal-friendly logging for HTTP calls. Use from [ApiClient] or
/// anywhere you need consistent request/response/error output.
abstract final class ApiNetworkLogger {
  ApiNetworkLogger._();

  static const int _maxBodyChars = 8000;

  static bool enabled = kDebugMode;

  /// Keys matched case-insensitively; values are replaced in logs.
  static const Set<String> _sensitiveHeaderKeys = {
    'authorization',
    'cookie',
    'set-cookie',
    'x-api-key',
    'api-key',
  };

  static void logRequest({
    required String method,
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
  }) {
    if (!enabled) return;
    _banner('REQUEST  $method');
    debugPrint('  URL     : $uri');
    if (headers != null && headers.isNotEmpty) {
      debugPrint('  Headers : ${_formatHeaders(headers)}');
    }
    if (body != null) {
      debugPrint('  Body    :\n${_indent(_stringifyBody(body))}');
    }
    _rule();
  }

  static void logResponse({
    required String method,
    required Uri uri,
    required http.Response response,
    required Duration duration,
  }) {
    if (!enabled) return;
    final ok = response.statusCode >= 200 && response.statusCode < 300;
    final label = ok ? 'RESPONSE' : 'RESPONSE (non-success)';
    _banner(
      '$label  $method  ${response.statusCode}  ${duration.inMilliseconds}ms',
    );
    debugPrint('  URL     : $uri');
    if (response.headers.isNotEmpty) {
      debugPrint('  Headers : ${_formatHeaders(response.headers)}');
    }
    final body = _truncate(response.body);
    debugPrint('  Body    :\n${_indent(_prettyJsonIfPossible(body))}');
    _rule();
  }

  static void logError({
    required String method,
    required Uri uri,
    required Object error,
    StackTrace? stackTrace,
    Duration? duration,
    Map<String, String>? requestHeaders,
    Object? requestBody,
  }) {
    if (!enabled) return;
    final ms = duration != null ? '  ${duration.inMilliseconds}ms' : '';
    _banner('ERROR  $method$ms');
    debugPrint('  URL     : $uri');
    if (requestHeaders != null && requestHeaders.isNotEmpty) {
      debugPrint('  Headers : ${_formatHeaders(requestHeaders)}');
    }
    if (requestBody != null) {
      debugPrint('  Body    :\n${_indent(_stringifyBody(requestBody))}');
    }
    debugPrint('  Error   : $error');
    if (stackTrace != null) {
      debugPrint('  Stack   :\n${_indent(stackTrace.toString())}');
    }
    _rule();
  }

  static void _banner(String title) {
    debugPrint('');
    debugPrint('┌── $title ${'─' * (72 - title.length)}');
  }

  static void _rule() {
    debugPrint('└${'─' * 74}');
  }

  static String _indent(String s) =>
      s.split('\n').map((l) => '    $l').join('\n');

  static String _truncate(String s) {
    if (s.length <= _maxBodyChars) return s;
    return '${s.substring(0, _maxBodyChars)}\n    … (${s.length - _maxBodyChars} more chars)';
  }

  static String _stringifyBody(Object body) {
    if (body is String) return _prettyJsonIfPossible(body);
    return body.toString();
  }

  static String _prettyJsonIfPossible(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return '(empty)';
    try {
      final decoded = jsonDecode(trimmed);
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return raw;
    }
  }

  static String _formatHeaders(Map<String, String> headers) {
    final buf = StringBuffer();
    headers.forEach((key, value) {
      final lower = key.toLowerCase();
      final safe = _sensitiveHeaderKeys.contains(lower) ? '***' : value;
      buf.write('\n    $key: $safe');
    });
    return buf.isEmpty ? '(none)' : buf.toString();
  }
}
