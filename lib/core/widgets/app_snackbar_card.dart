import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Visual variant for [AppSnackbarCard] (success / error / info).
enum AppSnackbarVariant { success, error, info }

/// Toast card aligned with Intent typography (Inter + intent text colors).
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

  static final List<BoxShadow> _outlinedFieldShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final icon = switch (variant) {
      AppSnackbarVariant.success => Icon(
          Icons.check_circle_rounded,
          size: 26,
          color: AppColors.usernameAvailable,
        ),
      AppSnackbarVariant.error => Icon(
          Icons.info_outline_rounded,
          size: 26,
          color: AppColors.error,
        ),
      AppSnackbarVariant.info => Icon(
          Icons.info_outline_rounded,
          size: 26,
          color: AppColors.intentGold,
        ),
    };

    final hasTitle = title.isNotEmpty;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.65),
        ),
        boxShadow: _outlinedFieldShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasTitle) ...[
                  Text(
                    title,
                    style: IntentLoginStyles.snackbarTitle,
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  message,
                  style: hasTitle
                      ? IntentLoginStyles.snackbarMessage
                      : IntentLoginStyles.snackbarMessageStandalone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
