import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _harmonyBadgeBg = Color(0xFFF8E9B8);
const _selectedReasonBg = Color(0xFFFAFAF8);
const _harassmentIconColor = Color(0xFFB85C5C);

enum ReportUserReason {
  harassment,
  fakeProfile,
  offPlatformPressure,
  inappropriateMessage,
  unsafeBehavior,
  other,
}

class ReportUserIntroSection extends StatelessWidget {
  const ReportUserIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tell us what happened. Reports are reviewed privately to help '
          'keep Intent safe and respectful.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 15,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Center(child: ReportUserPrivateBadge()),
      ],
    );
  }
}

class ReportUserPrivateBadge extends StatelessWidget {
  const ReportUserPrivateBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 6),
          Text(
            'Private report',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.intentText,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportUserProfileCard extends StatelessWidget {
  const ReportUserProfileCard({
    super.key,
    this.name = 'Julian',
    this.harmonyPercent = 94,
  });

  final String name;
  final int harmonyPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.asset(
              AppAssets.demoPreviewPhoto,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Match',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    color: AppColors.intentTextSoft,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _harmonyBadgeBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 10,
                        color: AppColors.intentGold.withValues(alpha: 0.95),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$harmonyPercent% Harmony',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.intentText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.9),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 72,
                child: Text(
                  'This report is not shown to the user.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 10,
                    height: 1.35,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReportUserReasonSection extends StatelessWidget {
  const ReportUserReasonSection({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ReportUserReason selected;
  final ValueChanged<ReportUserReason> onSelected;

  static final _reasons = [
    _ReasonItem(
      ReportUserReason.harassment,
      Icons.warning_amber_outlined,
      const Color(0xFFF9E8E8),
      _harassmentIconColor,
      'Harassment or disrespect',
    ),
    _ReasonItem(
      ReportUserReason.fakeProfile,
      Icons.person_outline,
      const Color(0xFFF4F7FB),
      AppColors.intentTextSoft,
      'Fake or misleading profile',
    ),
    _ReasonItem(
      ReportUserReason.offPlatformPressure,
      Icons.open_in_new,
      const Color(0xFFF4F7FB),
      AppColors.intentTextSoft,
      'Pressure to move off-platform',
    ),
    _ReasonItem(
      ReportUserReason.inappropriateMessage,
      Icons.chat_bubble_outline,
      const Color(0xFFF4F7FB),
      AppColors.intentTextSoft,
      'Inappropriate message',
    ),
    _ReasonItem(
      ReportUserReason.unsafeBehavior,
      Icons.lock_outline,
      const Color(0xFFF4F7FB),
      AppColors.intentTextSoft,
      'Unsafe behavior',
    ),
    _ReasonItem(
      ReportUserReason.other,
      Icons.more_horiz,
      const Color(0xFFF4F7FB),
      AppColors.intentTextSoft,
      'Other',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reason for report',
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose the closest reason.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 14,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _reasons.length; i++)
            _ReportReasonTile(
              icon: _reasons[i].icon,
              iconBg: _reasons[i].iconBg,
              iconColor: _reasons[i].iconColor,
              title: _reasons[i].title,
              isSelected: selected == _reasons[i].reason,
              onTap: () => onSelected(_reasons[i].reason),
            ),
        ],
      ),
    );
  }
}

class _ReasonItem {
  const _ReasonItem(
    this.reason,
    this.icon,
    this.iconBg,
    this.iconColor,
    this.title,
  );

  final ReportUserReason reason;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
}

class _ReportReasonTile extends StatelessWidget {
  const _ReportReasonTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
            color: isSelected ? _selectedReasonBg : Colors.transparent,
            border: isSelected
                ? Border.all(
                    color: AppColors.intentText,
                    width: 1.5,
                  )
                : null,
            borderRadius: BorderRadius.circular(isSelected ? 18 : 0),
          ),
          margin: isSelected ? const EdgeInsets.all(6) : EdgeInsets.zero,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
              _ReportRadioIndicator(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportRadioIndicator extends StatelessWidget {
  const _ReportRadioIndicator({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: AppColors.intentText,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.85),
          width: 1.5,
        ),
      ),
    );
  }
}

class ReportUserDetailsSection extends StatefulWidget {
  const ReportUserDetailsSection({
    super.key,
    required this.controller,
    this.maxLength = 500,
  });

  final TextEditingController controller;
  final int maxLength;

  @override
  State<ReportUserDetailsSection> createState() =>
      _ReportUserDetailsSectionState();
}

class _ReportUserDetailsSectionState extends State<ReportUserDetailsSection> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final currentLength = widget.controller.text.length;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add details',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.65),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: widget.controller,
                  maxLines: 5,
                  maxLength: widget.maxLength,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 14,
                    height: 1.45,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Describe what happened...',
                    hintStyle: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 14,
                      color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$currentLength / ${widget.maxLength}',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      color: AppColors.intentTextSoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Include details that may help Intent review the situation.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              height: 1.4,
              color: AppColors.intentTextSoft,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportUserScreenshotSection extends StatelessWidget {
  const ReportUserScreenshotSection({
    super.key,
    this.showThumbnail = true,
    this.onRemoveScreenshot,
  });

  final bool showThumbnail;
  final VoidCallback? onRemoveScreenshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Attach screenshot (optional)',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Optional, but helpful if you want to include proof.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 14,
              color: AppColors.intentTextSoft,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _ScreenshotUploadBox()),
              if (showThumbnail) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: _ScreenshotThumbnail(onRemove: onRemoveScreenshot),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ScreenshotUploadBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.intentInputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.intentInputBorder.withValues(alpha: 0.75),
          radius: 14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_outlined,
              size: 22,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(height: 8),
            Text(
              'Add screenshot',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'PNG or JPG',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 11,
                color: AppColors.intentTextSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenshotThumbnail extends StatelessWidget {
  const _ScreenshotThumbnail({this.onRemove});

  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            AppAssets.demoGalleryPhoto,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.95),
                shape: BoxShape.circle,
                boxShadow: AppShadows.intentInput,
              ),
              child: Icon(
                Icons.close,
                size: 14,
                color: AppColors.intentTextSoft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ReportUserBlockSection extends StatelessWidget {
  const ReportUserBlockSection({
    super.key,
    required this.blockUser,
    required this.onChanged,
  });

  final bool blockUser;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Block this user',
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Prevent this user from contacting you after the report '
                  'is submitted.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: blockUser,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.intentForest,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.intentInputBorder,
          ),
        ],
      ),
    );
  }
}

class ReportUserPrivacyCard extends StatelessWidget {
  const ReportUserPrivacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: AppColors.intentTextSoft,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your report stays private',
                      style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Intent reviews reports privately. The reported user '
                      'will not see your report details.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.intentInputBorder.withValues(alpha: 0.35),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.health_and_safety_outlined,
                size: 16,
                color: AppColors.intentTextSoft,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'If there is immediate danger, contact local emergency '
                  'services first.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.45,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReportUserSubmitButton extends StatelessWidget {
  const ReportUserSubmitButton({super.key, this.onPressed});

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
                Icons.verified_user_outlined,
                size: 18,
                color: AppColors.white,
              ),
              const SizedBox(width: 4),
              Text(
                'Submit Report',
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

class ReportUserCancelLink extends StatelessWidget {
  const ReportUserCancelLink({super.key, this.onTap});

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
            'Cancel',
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
