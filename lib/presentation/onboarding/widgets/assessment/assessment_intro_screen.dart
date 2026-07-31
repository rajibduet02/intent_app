import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_sync.dart';

const double assessmentIntroPinnedFooterHeight = 76;

class AssessmentIntroScreen extends StatelessWidget {
  const AssessmentIntroScreen({
    super.key,
    required this.onBack,
    this.sectionLabel,
    required this.title,
    this.subtitle,
    required this.description,
    required this.instruction,
    required this.onContinue,
    this.continueLabel = 'BEGIN',
    this.assessmentIndex,
    this.assessmentTotal = 5,
  });

  final VoidCallback onBack;
  final String? sectionLabel;
  final String title;
  final String? subtitle;
  final String description;
  final String instruction;
  final VoidCallback onContinue;
  final String continueLabel;
  final int? assessmentIndex;
  final int assessmentTotal;

  @override
  Widget build(BuildContext context) {
    final questionIndex = assessmentIndex ?? 1;

    return OnboardingProgressSync(
      phase: OnboardingPhase.howYouConnect,
      questionIndex: questionIndex,
      child: FixedBackgroundAuthScaffold(
        pinnedFooter: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: OnboardingContinueButton(
            label: continueLabel,
            onPressed: onContinue,
          ),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
            bottom: 24 + assessmentIntroPinnedFooterHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgressHeader(
                onBack: onBack,
                questionLabelOverride:
                    'Assessment $questionIndex of $assessmentTotal',
              ),
              const SizedBox(height: AppSpacing.xs),
              const Center(child: IntentLogo()),
              const SizedBox(height: AppSpacing.sm),
              if (sectionLabel != null) ...[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color:
                          AppColors.intentGoldMuted.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      sectionLabel!,
                      style: IntentLoginStyles.onboardingAssessmentCategory
                          .copyWith(
                        color: AppColors.intentGold,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Text(
                title,
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingTitle,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.intentInputBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.intentGold.withValues(alpha: 0.9),
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        instruction,
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 14,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
