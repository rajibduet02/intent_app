import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/core/network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
