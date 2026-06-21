import 'package:flutter/material.dart';

import 'package:intent_app/core/constants/app_constants.dart';

abstract final class Validators {
  Validators._();

  /// Validation error copy — Figma 370×10 frame, 14px regular, #C8454A.
  static const double errorMessageLayoutWidth = 370;
  static const double errorMessageFontSize = 14;
  static const Color errorMessageColor = Color(0xFFC8454A);

  /// TikTok Sans 18pt SemiExpanded — line-height 100%, letter-spacing 0%.
  static const TextStyle errorMessageStyle = TextStyle(
    fontFamily: 'TikTokSansExpanded',
    fontWeight: FontWeight.w400,
    fontSize: errorMessageFontSize,
    height: 1.0,
    letterSpacing: 0,
    color: errorMessageColor,
  );

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final v = value.trim();
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(v)) {
      return 'Enter valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    return null;
  }

  /// Password reset / new password (minimum [AppConstants.minPasswordLengthReset]).
  static String? passwordReset(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLengthReset) {
      return 'Password must be at least ${AppConstants.minPasswordLengthReset} characters';
    }
    return null;
  }

  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Use for confirm-password fields; [other] is the primary password string to match.
  static String? confirmPassword(String? value, String other) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != other) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? optionalPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
