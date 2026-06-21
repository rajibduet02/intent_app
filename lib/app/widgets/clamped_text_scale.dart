import 'package:flutter/material.dart';

/// Lower bound for app text scaling (avoids unreadably small UI when system scale < 1).
const double kAppMinTextScale = 0.8;
// const double kAppMinTextScale = 1.0;

/// Upper bound — allows modest accessibility scaling without breaking fixed layouts.
const double kAppMaxTextScale = 1.1;

/// Applies a clamped [TextScaler] via [MediaQuery] while preserving all other
/// [MediaQueryData] fields (padding, viewInsets, size, accessibility features).
class ClampedTextScale extends StatelessWidget {
  const ClampedTextScale({super.key, required this.child});

  final Widget child;

  /// Maps the platform [TextScaler] to a linear scaler within [kAppMinTextScale]…[kAppMaxTextScale].
  static TextScaler clamp(TextScaler systemScaler) {
    final scale = systemScaler
        .scale(1.0)
        .clamp(kAppMinTextScale, kAppMaxTextScale);
    return TextScaler.linear(scale);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: clamp(mediaQuery.textScaler)),
      child: child,
    );
  }
}
