import 'package:flutter/material.dart';

/// Central animation durations and curves for the entire application.
abstract final class AppAnimations {
  AppAnimations._();

  // --- Durations ---
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 140);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration medium = Duration(milliseconds: 450);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration pulse = Duration(milliseconds: 1600);
  static const Duration splashMinBranding = Duration(milliseconds: 900);
  /// Full symbolic splash story (~3.4s) before exit hold.
  static const Duration splashStory = Duration(milliseconds: 3400);
  static const Duration splashExitHold = Duration(milliseconds: 400);
  static const Duration authDebounce = Duration(milliseconds: 150);
  static const Duration passwordPeek = Duration(milliseconds: 300);
  static const Duration resendCooldown = Duration(seconds: 90);
  static const int resendCooldownSeconds = 90;

  // --- Curves ---
  static const Curve standard = Curves.easeInOut;
  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve bounce = Curves.easeInOut;

  // --- Route transitions ---
  static const Duration routeFade = medium;

  // --- Button press scale ---
  static const Duration buttonScaleDown = instant;
  static const Duration buttonScaleUp = fast;
  static const double buttonPressedScale = 0.97;

  // --- Splash ---
  static const Duration splashIntro = slow;
  static const Duration splashPulse = pulse;
  static const double splashFadeBegin = 0.0;
  static const double splashFadeEnd = 1.0;
  static const double splashScaleBegin = 0.95;
  static const double splashScaleEnd = 1.0;
}
