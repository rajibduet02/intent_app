import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography for the Intent login screen (Figma).
abstract final class IntentLoginStyles {
  IntentLoginStyles._();

  static TextStyle get brandTitle => GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.1,
        letterSpacing: 0.5,
      );

  static TextStyle get tagline => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get subTagline => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft,
        height: 1.2,
        letterSpacing: 2.4,
      );

  static TextStyle get fieldHint => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.4,
      );

  static TextStyle get rememberMe => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get forgotPassword => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.intentGold,
        height: 1.2,
      );

  static TextStyle get continueButton => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle get orContinueWith => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.2,
      );

  static TextStyle get socialButton => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get safetyTitle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get safetySubtitle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.4,
      );

  // --- Signup ---
  static TextStyle get signupTitle => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.15,
      );

  static TextStyle get signupSubtitle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.45,
      );

  static TextStyle get fieldLabel => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get createAccountButton => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.intentGold,
        height: 1.2,
      );

  static TextStyle get termsBody => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.4,
      );

  static TextStyle get termsLink => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.intentGold,
        height: 1.4,
      );

  static TextStyle get safetyCardTitle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get safetyCardBody => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.45,
      );

  static TextStyle get safetyCardFooter => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.intentGold,
        height: 1.3,
      );

  static TextStyle get footerPrompt => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.3,
      );

  static TextStyle get footerLink => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentGold,
        height: 1.3,
      );

  // --- Verify ---
  static TextStyle get verifyTitle => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.15,
      );

  static TextStyle get verifyBody => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.45,
      );

  static TextStyle get verifyDestination => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get verifyEditLink => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentGold,
        height: 1.3,
      );

  static TextStyle get verifyTimer => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.intentGold,
        height: 1.2,
      );

  static TextStyle get verifyResendPrompt => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.3,
      );

  static TextStyle get verifyResendLink => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentGold,
        height: 1.3,
      );

  static TextStyle get verifyStepLabel => GoogleFonts.inter(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft,
        height: 1.1,
      );

  static TextStyle get verifyStepLabelActive => GoogleFonts.inter(
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: AppColors.intentGold,
        height: 1.1,
      );

  static TextStyle get verifyAlmostThere => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  // --- Welcome ---
  static TextStyle get welcomeHeadline => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get welcomeHeadlineItalic => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get welcomeSubtext => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.55,
      );

  static TextStyle get welcomeGetStarted => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle get welcomeLogIn => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get welcomeValueLabel => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get welcomeFooter => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft.withValues(alpha: 0.75),
        height: 1.3,
        letterSpacing: 1.8,
      );

  // --- Onboarding ---
  static TextStyle get onboardingTitle => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get onboardingSubtitle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.intentTextSoft,
        height: 1.45,
      );

  static TextStyle get onboardingHelper => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.intentTextSoft,
        height: 1.35,
      );

  static TextStyle get onboardingPrivacy => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.intentTextSoft,
        height: 1.4,
      );

  static TextStyle get onboardingContinue => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
        letterSpacing: 1.2,
      );

  static TextStyle get onboardingGenderSelected => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle get onboardingGenderUnselected => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get onboardingStepBanner => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft,
        height: 1.2,
        letterSpacing: 1.4,
      );

  static TextStyle get onboardingCardFieldLabel => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get onboardingFooterNote => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.intentTextSoft,
        height: 1.4,
      );

  static TextStyle get onboardingSectionTitle => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get onboardingValueChip => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  static TextStyle get onboardingLifestyleChip => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get onboardingDealbreaker => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get onboardingPlusNote => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.intentGold,
        height: 1.3,
      );

  static TextStyle get onboardingAssessmentTitle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.25,
      );

  static TextStyle get onboardingAssessmentCategory => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft,
        height: 1.2,
        letterSpacing: 1.1,
      );

  // --- MBTI assessment ---
  static TextStyle get mbtiNavTitle => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.2,
      );

  static TextStyle get mbtiSectionLabel => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft,
        height: 1.2,
      );

  static TextStyle get mbtiQuestion => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get mbtiOption => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.intentText,
        height: 1.3,
      );

  static TextStyle get mbtiProgress => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.intentTextSoft,
        height: 1.2,
      );

  static TextStyle get mbtiSubmit => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.2,
        letterSpacing: 1.2,
      );
}
