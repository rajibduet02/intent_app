import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/providers/verify_provider.dart';
import 'package:intent_app/presentation/auth/providers/verify_route_args.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/auth/widgets/verify/verify_header.dart';
import 'package:intent_app/presentation/auth/widgets/verify/verify_otp_input.dart';
import 'package:intent_app/presentation/auth/widgets/verify/verify_submit_button.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = VerifyRouteArgs.parse(GoRouterState.of(context).extra);
    if (args == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go(AppRoutes.signup);
        }
      });
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(verifyProvider.notifier).initialize(args);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(
      verifyProvider.select((s) => s.verificationSucceeded),
      (previous, succeeded) {
        if (succeeded && context.mounted) {
          context.go(AppRoutes.introDatingIntention);
        }
      },
    );

    final verifyNotifier = ref.read(verifyProvider.notifier);
    final verifyState = ref.watch(verifyProvider);
    final args = verifyState.args;

    if (args == null) {
      return const FixedBackgroundAuthScaffold(
        child: SizedBox.shrink(),
      );
    }

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IntentBackButton(onPressed: verifyNotifier.onBack),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const VerifyHeader(),
            const SizedBox(height: 20),
            Text(
              'We’ve sent a 6-digit code to',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.verifyBody,
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  args.displayDestination,
                  style: IntentLoginStyles.verifyDestination,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: verifyNotifier.onEditDestination,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'Edit',
                    style: IntentLoginStyles.verifyEditLink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            VerifyOtpInput(
              onChanged: verifyNotifier.updateOtp,
              onCompleted: verifyNotifier.onOtpCompleted,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 16,
                  color: AppColors.intentGold,
                ),
                const SizedBox(width: 6),
                Text(
                  'Code expires in ',
                  style: IntentLoginStyles.verifyTimer.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.intentTextSoft,
                  ),
                ),
                Text(
                  verifyState.formattedTimer,
                  style: IntentLoginStyles.verifyTimer,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Didn’t receive the code? ',
                  style: IntentLoginStyles.verifyResendPrompt,
                ),
                GestureDetector(
                  onTap: verifyState.canResend && !verifyState.isResending
                      ? () => unawaited(verifyNotifier.resendCode())
                      : null,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'Resend code',
                    style: IntentLoginStyles.verifyResendLink.copyWith(
                      color: verifyState.canResend
                          ? AppColors.intentGold
                          : AppColors.intentGold.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            VerifySubmitButton(
              isLoading: verifyState.isLoading,
              enabled: verifyState.otp.length == 6 && !verifyState.isLoading,
              onPressed: () => unawaited(verifyNotifier.submitOtp()),
            ),
            const SizedBox(height: 16),
            const VerifyFooterMessage(),
          ],
        ),
      ),
    );
  }
}
