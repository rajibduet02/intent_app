import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/bootstrap/auth_state_bootstrap.dart';
import 'package:intent_app/app/providers/provider_bootstrap.dart';
import 'package:intent_app/app/providers/shared_preferences_provider.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/theme/app_theme.dart';
import 'package:intent_app/app/widgets/clamped_text_scale.dart';
import 'package:intent_app/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseReady = false;
  try {
    await Firebase.initializeApp();
    firebaseReady = true;
  } catch (e, st) {
    debugPrint(
      'Firebase is not configured yet. Run `flutterfire configure` to enable auth.',
    );
    debugPrint('$e');
    debugPrint('$st');
  }

  final prefs = await SharedPreferences.getInstance();
  initAppProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  if (firebaseReady) {
    AuthStateBootstrap.start();
  }
  runApp(
    UncontrolledProviderScope(
      container: appProviderContainer,
      child: const IntentApp(),
    ),
  );
}

class IntentApp extends StatelessWidget {
  const IntentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
      builder: (context, child) {
        return ClampedTextScale(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
