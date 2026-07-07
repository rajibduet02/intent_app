import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';

/// Pops the navigation stack until [AppRoutes.chat] is reached, or pops once
/// if chat is not found in the stack.
void popToChat(BuildContext context) {
  final router = GoRouter.of(context);
  while (context.canPop() && router.state.matchedLocation != AppRoutes.chat) {
    context.pop();
  }
  if (router.state.matchedLocation != AppRoutes.chat && context.canPop()) {
    context.pop();
  }
}

Future<bool> showDeclineProposalDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Decline this date?',
        style: IntentLoginStyles.onboardingSectionTitle.copyWith(
          fontSize: 20,
        ),
      ),
      content: Text(
        'Julian will be notified respectfully. You can continue chatting '
        'if you would like.',
        style: IntentLoginStyles.onboardingSubtitle.copyWith(
          fontSize: 14,
          height: 1.45,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Decline',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.danger,
            ),
          ),
        ),
      ],
    ),
  );
  return confirmed == true;
}

Future<void> showReportSubmittedDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Report submitted',
        style: IntentLoginStyles.onboardingSectionTitle.copyWith(
          fontSize: 20,
        ),
      ),
      content: Text(
        'Thank you for helping keep Intent safe. Our team will review your '
        'report.',
        style: IntentLoginStyles.onboardingSubtitle.copyWith(
          fontSize: 14,
          height: 1.45,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Done',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.intentForest,
            ),
          ),
        ),
      ],
    ),
  );
}
