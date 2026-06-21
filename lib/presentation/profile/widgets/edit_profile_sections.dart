import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class EditProfileCard extends StatelessWidget {
  const EditProfileCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}

class EditProfileSectionHeader extends StatelessWidget {
  const EditProfileSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.intentForest),
        const SizedBox(width: 8),
        Text(
          title,
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class EditProfileFooterNote extends StatelessWidget {
  const EditProfileFooterNote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: IntentLoginStyles.onboardingSubtitle.copyWith(
        fontSize: 11,
        height: 1.45,
        color: AppColors.intentTextSoft,
      ),
    );
  }
}

class EditProfilePhotosCard extends StatelessWidget {
  const EditProfilePhotosCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(
            child: EditProfileCard(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 14),
              child: _EditProfilePhotoColumn(),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: EditProfileCard(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 14),
              child: _EditPreviewPhotoColumn(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditProfilePhotoColumn extends StatelessWidget {
  const _EditProfilePhotoColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.intentForest,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'Y',
                style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                  fontSize: 34,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Positioned(
              right: -2,
              bottom: -2,
              child: _EditProfilePhotoEditBadge(),
            ),
          ],
        ),
        const Spacer(),
        const EditProfileBeigeButton(label: 'Change avatar/icon'),
        const SizedBox(height: 8),
        Text(
          'Your icon appears before photos unlock.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 10,
            height: 1.35,
            color: AppColors.intentTextSoft,
          ),
        ),
      ],
    );
  }
}

class _EditPreviewPhotoColumn extends StatelessWidget {
  const _EditPreviewPhotoColumn();

  static const _photoHeight = 112.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: _photoHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.intentCreamDeep,
                              AppColors.intentForest.withValues(alpha: 0.78),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.intentForest.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'PREVIEW PHOTO',
                          style: IntentLoginStyles.onboardingAssessmentCategory
                              .copyWith(
                            fontSize: 7,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              right: -4,
              bottom: -4,
              child: _EditProfilePhotoEditBadge(),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'This is the one photo that can unlock after a date is proposed.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 10,
            height: 1.35,
            color: AppColors.intentTextSoft,
          ),
        ),
        const Spacer(),
        const EditProfileBeigeButton(label: 'Change preview photo'),
      ],
    );
  }
}

class _EditProfilePhotoEditBadge extends StatelessWidget {
  const _EditProfilePhotoEditBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(
        Icons.edit_outlined,
        size: 12,
        color: AppColors.intentTextSoft.withValues(alpha: 0.95),
      ),
    );
  }
}

class EditProfileBeigeButton extends StatelessWidget {
  const EditProfileBeigeButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          backgroundColor: AppColors.intentSegmentFill,
          foregroundColor: AppColors.intentForest,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.intentForest,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}

class EditProfileFieldRow extends StatelessWidget {
  const EditProfileFieldRow({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 11,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: AppColors.intentInputFill,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: AppSpacing.inputFieldHeight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.65),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: AppColors.intentTextSoft),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      value,
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 13),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EditProfileDropdownField extends StatelessWidget {
  const EditProfileDropdownField({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 11,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: AppColors.intentInputFill,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: AppSpacing.inputFieldHeight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.65),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 13),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                    color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EditProfileIntentionOption extends StatelessWidget {
  const EditProfileIntentionOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.intentForest : AppColors.intentSegmentFill,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentForest
                  : AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 13,
                    color: isSelected ? AppColors.white : AppColors.intentText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileDealbreakerToggle extends StatelessWidget {
  const EditProfileDealbreakerToggle({
    super.key,
    this.icon,
    required this.label,
    required this.isOn,
    required this.onChanged,
  });

  final IconData? icon;
  final String label;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: AppColors.intentTextSoft.withValues(alpha: 0.85),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Text(
            label,
            style: IntentLoginStyles.onboardingDealbreaker.copyWith(
              fontSize: 13,
            ),
          ),
        ),
        Switch.adaptive(
          value: isOn,
          onChanged: onChanged,
          activeTrackColor: AppColors.intentForest.withValues(alpha: 0.35),
          activeThumbColor: AppColors.intentForest,
        ),
      ],
    );
  }
}

class EditProfileLifestyleRow extends StatelessWidget {
  const EditProfileLifestyleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.intentTextSoft),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              value,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.intentForest,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.intentTextSoft.withValues(alpha: 0.75),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class EditProfileValueChip extends StatelessWidget {
  const EditProfileValueChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.intentForest : AppColors.intentSegmentFill,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.intentForest
                : AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.intentText,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              const Icon(Icons.check, size: 12, color: AppColors.white),
            ],
          ],
        ),
      ),
    );
  }
}

class EditProfileDealbreakerSummaryRow extends StatelessWidget {
  const EditProfileDealbreakerSummaryRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showValueStar = false,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool showValueStar;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(
                icon,
                size: 14,
                color: AppColors.intentTextSoft.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 11,
                      height: 1.35,
                      color: AppColors.intentTextSoft,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          value,
                          style: IntentLoginStyles.onboardingCardFieldLabel
                              .copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.35,
                          ),
                        ),
                      ),
                      if (showValueStar) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.star_outline,
                          size: 12,
                          color: AppColors.intentTextSoft.withValues(
                            alpha: 0.75,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class EditProfilePhotoPrivacyCard extends StatelessWidget {
  const EditProfilePhotoPrivacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EditProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EditProfileSectionHeader(
            icon: Icons.lock_outline,
            title: 'Photo Privacy',
          ),
          const SizedBox(height: 12),
          Text(
            'Your full gallery stays hidden until you and a match agree '
            'to move forward with a date.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                Text(
                  'Manage hidden gallery',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.intentForest,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.intentForest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileSaveButton extends StatelessWidget {
  const EditProfileSaveButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.intentForest,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
              child: const Icon(
                Icons.check,
                size: 13,
                color: AppColors.white,
              ),
            ),
            Expanded(
              child: Text(
                'Save Changes',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingContinue,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 22,
              color: AppColors.intentGold,
            ),
          ],
        ),
      ),
    );
  }
}
