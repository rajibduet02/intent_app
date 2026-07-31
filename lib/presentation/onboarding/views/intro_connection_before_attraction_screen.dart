import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/widgets/section_intro_page.dart';

class IntroConnectionBeforeAttractionScreen extends StatelessWidget {
  const IntroConnectionBeforeAttractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionIntroPage(
      onBack: () => appRouter.go(AppRoutes.introDatingIntention),
      title: 'Why Intent is different',
      subtitle:
          'Most apps lead with photos. Intent starts with who you are '
          'and what you are looking for.',
      extra: const _PriorityList(),
      onContinue: () => appRouter.go(AppRoutes.introThoughtfulProfile),
    );
  }
}

class _PriorityList extends StatelessWidget {
  const _PriorityList();

  static const _items = [
    'Values',
    'Personality',
    'Relationship goals',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'We prioritize',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        for (final item in _items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: AppShadows.intentInput,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: AppColors.intentForest,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      item,
                      style: IntentLoginStyles.onboardingAssessmentTitle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 4),
        Text(
          'before photos are revealed.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}
