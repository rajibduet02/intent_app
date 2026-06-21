import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intent_app/core/config/env.dart';
import 'package:intent_app/core/network/api_network_logger.dart';

/// HTTP client for the data layer. Extend with auth headers, interceptors, etc.
class ApiClient {
  ApiClient({http.Client? client, bool? logRequests})
    : _client = client ?? http.Client(),
      _logRequests = logRequests ?? ApiNetworkLogger.enabled;

  final http.Client _client;
  final bool _logRequests;

  Map<String, String> get _jsonHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final uri = Uri.parse('${Env.apiBaseUrl}$path');
    final merged = {..._jsonHeaders, ...?headers};
    if (_logRequests) {
      ApiNetworkLogger.logRequest(method: 'GET', uri: uri, headers: merged);
    }
    final sw = Stopwatch()..start();
    try {
      final res = await _client.get(uri, headers: merged);
      sw.stop();
      if (_logRequests) {
        ApiNetworkLogger.logResponse(
          method: 'GET',
          uri: uri,
          response: res,
          duration: sw.elapsed,
        );
      }
      return res;
    } catch (e, st) {
      sw.stop();
      if (_logRequests) {
        ApiNetworkLogger.logError(
          method: 'GET',
          uri: uri,
          error: e,
          stackTrace: st,
          duration: sw.elapsed,
          requestHeaders: merged,
        );
      }
      rethrow;
    }
  }

  Future<http.Response> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('${Env.apiBaseUrl}$path');
    final merged = {..._jsonHeaders, ...?headers};
    final encoded = body == null ? null : jsonEncode(body);
    if (_logRequests) {
      ApiNetworkLogger.logRequest(
        method: 'POST',
        uri: uri,
        headers: merged,
        body: body ?? encoded,
      );
    }
    final sw = Stopwatch()..start();
    try {
      final res = await _client.post(uri, headers: merged, body: encoded);
      sw.stop();
      if (_logRequests) {
        ApiNetworkLogger.logResponse(
          method: 'POST',
          uri: uri,
          response: res,
          duration: sw.elapsed,
        );
      }
      return res;
    } catch (e, st) {
      sw.stop();
      if (_logRequests) {
        ApiNetworkLogger.logError(
          method: 'POST',
          uri: uri,
          error: e,
          stackTrace: st,
          duration: sw.elapsed,
          requestHeaders: merged,
          requestBody: body ?? encoded,
        );
      }
      rethrow;
    }
  }

  void dispose() {
    _client.close();
  }
}
