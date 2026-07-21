import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/providers/profile_basics_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/profile_basics_state.dart';

class OnboardingGenderSelector extends ConsumerWidget {
  const OnboardingGenderSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(profileBasicsProvider.select((s) => s.gender));
    final notifier = ref.read(profileBasicsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('I am a', style: IntentLoginStyles.fieldLabel),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.intentSegmentFill,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _GenderOption(
                label: 'Woman',
                isSelected: selected == OnboardingGender.woman,
                onTap: () => notifier.setGender(OnboardingGender.woman),
              ),
              _GenderOption(
                label: 'Man',
                isSelected: selected == OnboardingGender.man,
                onTap: () => notifier.setGender(OnboardingGender.man),
              ),
              _GenderOption(
                label: 'Non-binary',
                isSelected: selected == OnboardingGender.nonBinary,
                onTap: () => notifier.setGender(OnboardingGender.nonBinary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.intentForest : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: isSelected
                ? IntentLoginStyles.onboardingGenderSelected
                : IntentLoginStyles.onboardingGenderUnselected,
          ),
        ),
      ),
    );
  }
}
