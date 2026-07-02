import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_value_chip.dart';

class FilterIntroSection extends StatelessWidget {
  const FilterIntroSection({
    super.key,
    required this.activeFilterCount,
  });

  final int activeFilterCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Refine your discover feed',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 26),
        ),
        const SizedBox(height: 10),
        Text(
          'Adjust who you see while keeping Intent\'s compatibility-first '
          'approach.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 15,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.intentGoldMuted.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 18,
                color: AppColors.intentGold,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  activeFilterCount == 0
                      ? 'Showing your default discover preferences.'
                      : '$activeFilterCount active '
                          '${activeFilterCount == 1 ? 'filter' : 'filters'} '
                          'applied.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.intentText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FilterSectionCard extends StatelessWidget {
  const FilterSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
              color: AppColors.intentForest,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class FilterSliderRow extends StatelessWidget {
  const FilterSliderRow({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              valueLabel,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 14,
                color: AppColors.intentGold,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.intentForest,
            inactiveTrackColor: AppColors.intentProgressInactive,
            thumbColor: AppColors.intentForest,
            overlayColor: AppColors.intentForest.withValues(alpha: 0.12),
            trackHeight: 4,
          ),
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class FilterRangeSliderRow extends StatelessWidget {
  const FilterRangeSliderRow({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final String valueLabel;
  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              valueLabel,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 14,
                color: AppColors.intentGold,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: (max - min).round(),
          activeColor: AppColors.intentForest,
          inactiveColor: AppColors.intentProgressInactive,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class FilterChipGroup extends StatelessWidget {
  const FilterChipGroup({
    super.key,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        return OnboardingValueChip(
          label: option,
          isSelected: selected.contains(option),
          onTap: () => onToggle(option),
        );
      }).toList(),
    );
  }
}

class FilterToggleRow extends StatelessWidget {
  const FilterToggleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.intentSegmentFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: AppColors.intentForest,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.intentForest.withValues(alpha: 0.35),
              activeThumbColor: AppColors.intentForest,
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 14),
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.35),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class FilterPrivacyNote extends StatelessWidget {
  const FilterPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline,
            size: 16,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Filters do not change photo privacy. Profiles still unlock '
              'through the intentional date flow.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterApplyButton extends StatelessWidget {
  const FilterApplyButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSpacing.primaryButtonBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.intentForest.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppSpacing.primaryButtonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.intentForest,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.primaryButtonBorderRadius,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.tune,
                size: 18,
                color: AppColors.white,
              ),
              const SizedBox(width: 4),
              Text(
                'Apply Filters',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterResetLink extends StatelessWidget {
  const FilterResetLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Reset filters',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.intentText,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
