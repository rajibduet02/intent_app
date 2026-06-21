import 'package:flutter/material.dart';

/// Central color palette for the entire application.
abstract final class AppColors {
  AppColors._();

  // --- Theme / Material ---
  static const Color primary = Color(0xFF5133D3);
  static const Color primaryLegacy = Color(0xFF1565C0);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1B1B1F);
  static const Color error = Color(0xFFB3261E);
  static const Color background = Color(0xFFF8FAFC);

  // --- Brand blues ---
  static const Color accentBlue = Color(0xFF008FC2);
  static const Color accentBlueDeep = Color(0xFF002852);
  static const Color accentBlueMid = Color(0xFF0072A0);
  static const Color linkBlue = Color(0xFF076FA3);
  static const Color linkBlueDark = Color(0xFF066FA3);
  static const Color successAccent = Color(0xFF0E90C7);
  static const Color accentTeal = Color(0xFF1584AB);
  static const Color accentSky = Color(0xFF6DD4FF);
  static const Color accentBlueEnd = Color(0xFF165DA6);
  static const Color filterAccent = Color(0xFF0B84B8);
  static const Color filterGradientStart = Color(0xFF0E8BC2);
  static const Color filterGradientEnd = Color(0xFF072F73);
  static const Color skyBlue = Color(0xFF2D8DFF);

  // --- Navy / headings ---
  static const Color navy = Color(0xFF1F2A66);
  static const Color navyMid = Color(0xFF404A80);
  static const Color navyDeep = Color(0xFF2B356D);
  static const Color navyMuted = Color(0xFF525B88);
  static const Color title = Color(0xFF23316A);
  static const Color subtitle = Color(0xFF1B2652);
  static const Color footerLink = Color(0xFF5133D3);

  // --- Neutrals / body text ---
  static const Color muted = Color(0xFF525866);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color onSurfaceVariant = Color(0xFF5C5C62);
  static const Color mutedGray = Color(0xFF6B7280);
  static const Color separatorDot = Color(0xFF625E66);
  static const Color hint = Color(0xFF9AA0A6);
  static const Color iconMuted = Color(0xFF9AA0AE);
  static const Color avatarPlaceholder = Color(0xFF8096A8);
  static const Color glassMuted = Color(0xFFA0A7B8);
  static const Color disabled = Color(0xFF94A3B8);

  // --- Surfaces / fills ---
  static const Color white = Color(0xFFFFFFFF);
  static const Color pageBackground = Color(0xFFFFFFFF);
  static const Color pageFallback = Color(0xFFF7F8FA);
  static const Color segmentTrackFill = Color(0xFFF5F6F7);
  static const Color segmentTrack = Color(0xFFECEEF3);
  static const Color softFill = Color(0xFFF2F2F2);
  static const Color lightGray = Color(0xFFF5F6FA);
  static const Color inputMutedFill = Color(0xFFF5F6F8);
  static const Color locationFieldBorder = Color(0xFFF1F4F8);
  static const Color splashGray = Color(0xFFF5F5F5);
  static const Color otpCellFill = Color(0xFFFFFFFF);
  static const Color socialCircleFill = Color(0xFFFFFFFF);

  // --- Borders / dividers ---
  static const Color border = Color(0xFFE1E4EB);
  static const Color lightBorder = Color(0xFFD9DDE7);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color neutralBorder = Color(0xFFBCC1CC);
  static const Color searchDivider = Color(0xFFD6D2CE);
  static const Color progressTrack = Color(0xFFDDE1EA);
  static const Color authOutlinedFieldBorder = Color(0xFFEBEBEB);
  static const Color socialCircleBorder = Color(0xFFEBEBEB);
  static const Color otpBorderDefault = authOutlinedFieldBorder;

  static Color get authOutlinedFieldBorderFocused =>
      title.withValues(alpha: 0.55);

  // --- Semantic ---
  static const Color danger = Color(0xFFC8454A);
  static const Color errorState = danger;
  static const Color dangerBright = Color(0xFFD94B4B);
  static const Color dangerAlt = Color(0xFFD94141);
  static const Color fieldError = Color(0xFFE53935);
  static const Color redBadge = Color(0xFFE5484D);
  static const Color success = Color(0xFF428D47);
  static const Color usernameAvailable = success;
  static const Color successBright = Color(0xFF24972C);
  static const Color successGoogle = Color(0xFF34A853);
  static const Color warning = Color(0xFFF59E0B);
  static const Color gold = Color(0xFFC07A1F);
  static const Color goldBright = Color(0xFFC89B2C);
  static const Color eliteGold = Color(0xFFB97424);
  static const Color hostBadge = Color(0xFFC79200);

  // --- Dark / glass ---
  static const Color glassFill = Color(0xFF0B0F1A);
  static const Color glassInner = Color(0xFF121826);
  static const Color cyanGlow = Color(0xFFACF7FF);
  static const Color cyanGlowLight = Color(0xFFDEFCFF);
  static const Color cyanBright = Color(0xFF00E5FF);

  static const Color resendAction = footerLink;
  static const Color otpResendActive = footerLink;

  // --- Intent brand (login / auth) ---
  static const Color intentCream = Color(0xFFF8F4ED);
  static const Color intentCreamDeep = Color(0xFFEDE6DA);
  static const Color intentForest = Color(0xFF1E3F35);
  static const Color intentForestDark = Color(0xFF183329);
  static const Color intentGold = Color(0xFFC4A574);
  static const Color intentGoldMuted = Color(0xFFD9C4A0);
  static const Color intentText = Color(0xFF1E3F35);
  static const Color intentTextSoft = Color(0xFF5C6B65);
  static const Color intentInputFill = Color(0xFFFAF8F4);
  static const Color intentInputBorder = Color(0xFFE5DDD2);
  static const Color intentDividerGold = Color(0xFFD4BC94);
  static const Color intentSegmentFill = Color(0xFFF2F0E9);
  static const Color intentProgressInactive = Color(0xFFD8D2C8);
  static const Color intentSageSubmit = Color(0xFF8C9381);
  static const Color intentMbtiOptionFill = Color(0xFFF5F0E6);
  static const Color intentDiscoverMatch = Color(0xFF8B9474);
  static const Color intentNotificationDot = Color(0xFFE8A54B);
}
