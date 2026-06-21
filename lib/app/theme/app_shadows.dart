import 'package:flutter/material.dart';

/// Central shadow definitions for the entire application.
abstract final class AppShadows {
  AppShadows._();

  // --- Auth / form fields ---
  static const List<BoxShadow> authOutlinedField = [
    BoxShadow(
      color: Color(0x0A090E27),
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> otpCell = authOutlinedField;

  static const List<BoxShadow> basicInfoInput = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 4),
      blurRadius: 14,
    ),
  ];

  static const List<BoxShadow> bioTextArea = [
    BoxShadow(
      color: Color(0x08000000),
      offset: Offset(0, 2),
      blurRadius: 10,
    ),
  ];

  // --- Primary button elevations ---
  static List<BoxShadow> primarySoft({Color? color}) => [
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> primaryStandard({Color? color}) => [
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> primaryStrong({Color? color}) => [
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.18),
          blurRadius: 28,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> primaryLayered({Color? color}) => [
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> primaryLayeredSoft({Color? color}) => [
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> primaryMatchingContinue({Color? color}) => [
        BoxShadow(
          color: (color ?? Colors.black).withValues(alpha: 0.16),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];

  // --- Cards / home ---
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  static const List<BoxShadow> small = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 4),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> selectedSegmentGlow = [
    BoxShadow(
      color: Color(0x40008FC2),
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
    ...small,
  ];

  static const List<BoxShadow> fab = [
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 4),
      blurRadius: 2,
    ),
  ];

  // --- Intent login ---
  static const List<BoxShadow> intentBackButton = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> intentInput = [
    BoxShadow(
      color: Color(0x0A1E3F35),
      offset: Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static const List<BoxShadow> intentSocialButton = [
    BoxShadow(
      color: Color(0x08000000),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];
}
