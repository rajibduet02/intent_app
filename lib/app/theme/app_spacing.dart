import 'package:flutter/material.dart';

/// Central spacing scale for the entire application.
abstract final class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // --- Auth entry screens ---
  static const double titleFontSize = 24;
  static const double titleLineHeight = 1.2;
  static const double subtitleFontSize = 16;
  static const double subtitleLineHeight = 1.5;
  static const double titleMaxWidth = 370;
  static const double subtitleMaxWidth = 370;
  static const double backIconSize = 32;
  static const double backButtonSize = 40;
  static const double gapBackToTitle = lg;
  static const double gapTitleToSubtitle = 18;
  static const double gapSubtitleToFields = lg;
  static const double gapBetweenFields = 20;
  static const double gapFieldsToCta = xl;
  static const double gapCtaToSecondaryRow = 20;
  static const double gapSecondaryRowToContinueWith = 36;
  static const double gapContinueWithToSocial = md;
  static const double gapFooterPromptToLink = md;
  static const double footerPromptMaxWidth = 354;
  static const double footerLinkMaxWidth = 354;

  // --- OTP ---
  static const double otpCellWidth = 58.33333206176758;
  static const double otpCellHeight = 48;
  static const double otpBorderRadius = 48;
  static const double otpGap = xs;
  static const double otpRowWidth = otpCellWidth * 6 + otpGap * 5;
  static const double otpRowHeight = otpCellHeight;
  static const double gapOtpToResend = xl;

  // --- Layout ---
  /// Standard horizontal inset for all screen scroll/content areas.
  static const double screenHorizontal = md;
  static const EdgeInsets authScrollPadding =
      EdgeInsets.fromLTRB(screenHorizontal, 8, screenHorizontal, lg);
  static const double inputBorderRadius = 12;
  /// Standard height for text inputs and dropdown/select fields.
  static const double inputFieldHeight = 48;
  static const double inputFieldIconSize = 20;
  static const double inputFieldLeadingInset = 16;
  static const double inputFieldIconToTextGap = 4;
  static const double inputFieldTrailingInset = md;
  static const double inputFieldSuffixIconSize = 22;
  static const EdgeInsets inputFieldContentPadding =
      EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets inputFieldPrefixContentPadding =
      EdgeInsets.only(right: md);
  static const BoxConstraints inputFieldIconConstraints = BoxConstraints(
    minWidth: inputFieldLeadingInset +
        inputFieldIconSize +
        inputFieldIconToTextGap,
    minHeight: inputFieldHeight,
  );
  static const BoxConstraints inputFieldBoxConstraints = BoxConstraints(
    minHeight: inputFieldHeight,
    maxHeight: inputFieldHeight,
  );
  /// Full-width primary CTA buttons (reference: View Attachment Result).
  // static const double primaryButtonHeight = 52;
  static const double primaryButtonHeight = 48;
  static const double primaryButtonBorderRadius = 10;
  static const double buttonHeight = primaryButtonHeight;

  // --- Home / cards ---
  static const double cardRadius = 24;
  static const double pillRadius = 32;
  static const double joinButtonRadius = 32;
  static const double fabSize = 56;
  static const double fabCornerRadius = 36;
  static const double fabIconSize = 24;
  static const double fabVerticalInset = 9;
}
