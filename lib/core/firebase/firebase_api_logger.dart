import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Debug console logging for Firebase Auth, Firestore, and Callable Functions,
/// aligned with [ApiNetworkLogger] formatting. Never logs raw passwords or OTPs.
abstract final class FirebaseApiLogger {
  FirebaseApiLogger._();

  static const int _maxDataChars = 8000;

  static bool enabled = kDebugMode;

  static const Set<String> _sensitivePayloadKeys = {
    'password',
    'newpassword',
    'currentpassword',
    'code',
    'otp',
    'oobcode',
    'token',
    'idtoken',
    'refreshtoken',
    'accesstoken',
    'secret',
    'authorization',
  };

  static Map<String, dynamic>? sanitizeMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return map.map((key, value) {
      final k = key.toLowerCase();
      if (_sensitivePayloadKeys.contains(k)) {
        return MapEntry(key, '***');
      }
      if (value is Map) {
        return MapEntry(
          key,
          sanitizeMap(Map<String, dynamic>.from(value)) ?? <String, dynamic>{},
        );
      }
      return MapEntry(key, value);
    });
  }

  static Object? sanitizeParameters(dynamic parameters) {
    if (parameters is Map) {
      return sanitizeMap(Map<String, dynamic>.from(parameters));
    }
    return parameters;
  }

  /// HTTPS callable: logs request payload (sanitized), response `.data`, or
  /// [FirebaseFunctionsException] / other errors.
  static Future<HttpsCallableResult<T>> invokeHttpsCallable<T>({
    required HttpsCallable callable,
    required String functionName,
    dynamic parameters,
    String? functionsRegion,
  }) async {
    if (!enabled) {
      return callable.call<T>(parameters);
    }
    _banner('FIREBASE FUNCTIONS  REQUEST  $functionName');
    if (functionsRegion != null) {
      debugPrint('  Region  : $functionsRegion');
    }
    debugPrint(
      '  Payload :\n${_indent(_stringify(sanitizeParameters(parameters)))}',
    );
    _rule();

    final sw = Stopwatch()..start();
    try {
      final result = await callable.call<T>(parameters);
      sw.stop();
      _banner(
        'FIREBASE FUNCTIONS  RESPONSE  $functionName  ${sw.elapsedMilliseconds}ms',
      );
      debugPrint('  Data    :\n${_indent(_stringify(result.data))}');
      _rule();
      return result;
    } on FirebaseFunctionsException catch (e, st) {
      sw.stop();
      _logFunctionsException(
        functionName: functionName,
        functionsRegion: functionsRegion,
        e: e,
        stackTrace: st,
        duration: sw.elapsed,
        parameters: parameters,
      );
      rethrow;
    } catch (e, st) {
      sw.stop();
      _banner(
        'FIREBASE FUNCTIONS  ERROR  $functionName  ${sw.elapsedMilliseconds}ms',
      );
      if (functionsRegion != null) {
        debugPrint('  Region  : $functionsRegion');
      }
      debugPrint(
        '  Payload :\n${_indent(_stringify(sanitizeParameters(parameters)))}',
      );
      debugPrint('  Error   : $e');
      debugPrint('  Stack   :\n${_indent(st.toString())}');
      _rule();
      rethrow;
    }
  }

  /// Firebase Auth: logs operation name and optional non-secret context only.
  static Future<T> traceAuth<T>({
    required String operation,
    required Future<T> Function() action,
    String? context,
  }) async {
    if (!enabled) return action();
    _banner('FIREBASE AUTH  REQUEST  $operation');
    if (context != null && context.isNotEmpty) {
      debugPrint('  Context : $context');
    }
    _rule();

    final sw = Stopwatch()..start();
    try {
      final result = await action();
      sw.stop();
      _banner(
        'FIREBASE AUTH  RESPONSE  $operation  ${sw.elapsedMilliseconds}ms',
      );
      _rule();
      return result;
    } on FirebaseAuthException catch (e, st) {
      sw.stop();
      _banner('FIREBASE AUTH  ERROR  $operation  ${sw.elapsedMilliseconds}ms');
      if (context != null && context.isNotEmpty) {
        debugPrint('  Context : $context');
      }
      debugPrint('  code    : ${e.code}');
      debugPrint('  message : ${e.message}');
      debugPrint('  Stack   :\n${_indent(st.toString())}');
      _rule();
      rethrow;
    } catch (e, st) {
      sw.stop();
      _banner('FIREBASE AUTH  ERROR  $operation  ${sw.elapsedMilliseconds}ms');
      if (context != null && context.isNotEmpty) {
        debugPrint('  Context : $context');
      }
      debugPrint('  Error   : $e');
      debugPrint('  Stack   :\n${_indent(st.toString())}');
      _rule();
      rethrow;
    }
  }

  /// Firestore reads/writes/transactions: logs path label and timing.
  static Future<T> traceFirestore<T>({
    required String operation,
    required String path,
    required Future<T> Function() action,
  }) async {
    if (!enabled) return action();
    _banner('FIRESTORE  REQUEST  $operation');
    debugPrint('  Path    : $path');
    _rule();

    final sw = Stopwatch()..start();
    try {
      final result = await action();
      sw.stop();
      _banner(
        'FIRESTORE  RESPONSE  $operation  ${sw.elapsedMilliseconds}ms  ok',
      );
      debugPrint('  Path    : $path');
      _rule();
      return result;
    } on FirebaseException catch (e, st) {
      sw.stop();
      _banner('FIRESTORE  ERROR  $operation  ${sw.elapsedMilliseconds}ms');
      debugPrint('  Path    : $path');
      debugPrint('  plugin  : ${e.plugin}');
      debugPrint('  code    : ${e.code}');
      debugPrint('  message : ${e.message}');
      debugPrint('  Stack   :\n${_indent(st.toString())}');
      _rule();
      rethrow;
    } catch (e, st) {
      sw.stop();
      _banner('FIRESTORE  ERROR  $operation  ${sw.elapsedMilliseconds}ms');
      debugPrint('  Path    : $path');
      debugPrint('  Error   : $e');
      debugPrint('  Stack   :\n${_indent(st.toString())}');
      _rule();
      rethrow;
    }
  }

  static void _logFunctionsException({
    required String functionName,
    required FirebaseFunctionsException e,
    required StackTrace stackTrace,
    required Duration duration,
    String? functionsRegion,
    dynamic parameters,
  }) {
    _banner(
      'FIREBASE FUNCTIONS  ERROR  $functionName  ${duration.inMilliseconds}ms',
    );
    if (functionsRegion != null) {
      debugPrint('  Region  : $functionsRegion');
    }
    debugPrint(
      '  Payload :\n${_indent(_stringify(sanitizeParameters(parameters)))}',
    );
    debugPrint('  code    : ${e.code}');
    debugPrint('  message : ${e.message}');
    if (e.details != null) {
      debugPrint('  details :\n${_indent(_stringify(e.details))}');
    }
    debugPrint('  Stack   :\n${_indent(stackTrace.toString())}');
    _rule();
  }

  static void _banner(String title) {
    debugPrint('');
    final pad = math.max(0, 72 - title.length);
    debugPrint('┌── $title ${'─' * pad}');
  }

  static void _rule() {
    debugPrint('└${'─' * 74}');
  }

  static String _indent(String s) =>
      s.split('\n').map((l) => '    $l').join('\n');

  static String _stringify(Object? value) {
    if (value == null) return '(null)';
    try {
      final encoded = jsonEncode(value);
      final pretty = _prettyJsonIfPossible(encoded);
      return _truncate(pretty);
    } catch (_) {
      final raw = value.toString();
      return _truncate(raw);
    }
  }

  static String _prettyJsonIfPossible(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return '(empty)';
    try {
      final decoded = jsonDecode(t);
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return raw;
    }
  }

  static String _truncate(String s) {
    if (s.length <= _maxDataChars) return s;
    return '${s.substring(0, _maxDataChars)}\n    … (${s.length - _maxDataChars} more chars)';
  }
}
