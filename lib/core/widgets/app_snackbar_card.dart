import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Visual variant for [AppSnackbarCard] (success / soft error).
enum AppSnackbarVariant { success, error }

/// Light auth toast card — white surface, navy type, field-style border/shadow (Sign Up / auth UI).
class AppSnackbarCard extends StatelessWidget {
  const AppSnackbarCard({
    super.key,
    required this.variant,
    required this.title,
    required this.message,
  });

  final AppSnackbarVariant variant;
  final String title;
  final String message;

  /// Same elevation as [CustomAuthField] outlined (non-soft).
  static final List<BoxShadow> _outlinedFieldShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static const List<FontVariation> _title14 = [
    FontVariation('wdth', 125),
    FontVariation('wght', 600),
    FontVariation('opsz', 14),
  ];

  static const List<FontVariation> _body13 = [
    FontVariation('wdth', 125),
    FontVariation('wght', 400),
    FontVariation('opsz', 13),
  ];

  @override
  Widget build(BuildContext context) {
    final icon = variant == AppSnackbarVariant.success
        ? Icon(
            Icons.check_circle_rounded,
            size: 26,
            color: AppColors.usernameAvailable,
          )
        : Icon(
            Icons.info_outline_rounded,
            size: 26,
            color: AppColors.navy,
          );

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.otpBorderDefault, width: 1),
        boxShadow: _outlinedFieldShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title.isNotEmpty) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      // textAlign: TextAlign.center,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'TikTokSansExpanded',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.2,
                        letterSpacing: 0,
                        color: AppColors.navy,
                        fontVariations: _title14,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 4),
                  const SizedBox(height: 8),
                ],
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    message,
                    // textAlign: TextAlign.center,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'TikTokSansExpanded',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      height: 1.35,
                      letterSpacing: 0,
                      color: title.isNotEmpty
                          ? AppColors.muted
                          : AppColors.navy,
                      fontVariations: _body13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
