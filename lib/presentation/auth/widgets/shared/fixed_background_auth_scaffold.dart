import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';

/// Auth screen shell: decorative background stays fixed.
///
/// When [pinnedFooter] is set, it stays fixed at the bottom of the screen and
/// does not move when the keyboard opens; [child] scrolls/adjusts above it.
/// Set [extendPinnedFooterToBottom] for footers that should rise with the
/// keyboard and fill the device bottom inset (e.g. chat input).
class FixedBackgroundAuthScaffold extends StatelessWidget {
  const FixedBackgroundAuthScaffold({
    super.key,
    required this.child,
    this.pinnedFooter,
    this.extendPinnedFooterToBottom = false,
    this.pinnedFooterExtent,
  });

  final Widget child;
  final Widget? pinnedFooter;
  final bool extendPinnedFooterToBottom;
  final double? pinnedFooterExtent;

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final footerExtent = pinnedFooterExtent ?? 0;
    final extendFooter = extendPinnedFooterToBottom && pinnedFooter != null;

    return Scaffold(
      backgroundColor: AppColors.intentCream,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: LoginBackgroundDecor()),
          SafeArea(
            bottom: !extendFooter,
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(
                      bottom: keyboardInset +
                          (pinnedFooter != null ? footerExtent : 0),
                    ),
                    child: child,
                  ),
                ),
                if (pinnedFooter != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: extendFooter ? keyboardInset : 0,
                    child: pinnedFooter!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard back control used across auth, onboarding, and assessment screens.
class IntentBackButton extends StatelessWidget {
  const IntentBackButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      alignment: Alignment.centerLeft,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(
          AppSpacing.backButtonSize,
          AppSpacing.backButtonSize,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: const Icon(
        Icons.chevron_left,
        color: AppColors.intentForest,
        size: AppSpacing.backIconSize,
      ),
    );
  }
}
