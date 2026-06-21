import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Central typography for the entire application.
abstract final class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'TikTokSansExpanded';
  static const String displayFontFamily = fontFamily;

  // --- Theme scale ---
  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    height: 1.2,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppSpacing.titleFontSize,
    fontWeight: FontWeight.w700,
    height: AppSpacing.titleLineHeight,
    color: AppColors.title,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.45,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.subtitle,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  // --- Auth / form ---
  static const TextStyle fieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.2,
    color: AppColors.title,
  );

  static const TextStyle fieldHint = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: AppColors.subtitle,
  );

  static const TextStyle ctaLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.2,
    color: AppColors.onPrimary,
  );

  static const TextStyle footerPrompt = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.2,
    color: AppColors.subtitle,
  );

  static const TextStyle footerLink = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.2,
    letterSpacing: 0.42,
    color: AppColors.footerLink,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.footerLink,
    decorationThickness: 1,
  );

  static const TextStyle resendQuestion = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.2,
    color: AppColors.subtitle,
  );

  static const TextStyle resendAction = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.2,
    letterSpacing: 0.42,
    color: AppColors.resendAction,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.resendAction,
    decorationThickness: 1,
  );

  static TextStyle ctaLabelWithSize(double fontSize) => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        height: 1.2,
        color: AppColors.onPrimary,
      );

  // --- Font variations (variable font axes) ---
  static const List<FontVariation> brandBar = [
    FontVariation('wdth', 125),
    FontVariation('wght', 700),
    FontVariation('opsz', 18),
  ];

  static const List<FontVariation> title24 = [
    FontVariation('wdth', 125),
    FontVariation('wght', 700),
    FontVariation('opsz', 24),
  ];

  static const List<FontVariation> subtitle16 = [
    FontVariation('wdth', 125),
    FontVariation('wght', 400),
    FontVariation('opsz', 16),
  ];

  static const List<FontVariation> successLabel16 = [
    FontVariation('wdth', 125),
    FontVariation('wght', 600),
    FontVariation('opsz', 16),
  ];

  static const List<FontVariation> otpDigit20Regular = [
    FontVariation('wdth', 125),
    FontVariation('wght', 400),
    FontVariation('opsz', 20),
  ];

  static const List<FontVariation> otpDigit20Medium = [
    FontVariation('wdth', 125),
    FontVariation('wght', 500),
    FontVariation('opsz', 20),
  ];

  static const List<FontVariation> otpInvalidCode16 = [
    FontVariation('wdth', 125),
    FontVariation('wght', 400),
    FontVariation('opsz', 16),
  ];
}
