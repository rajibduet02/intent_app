import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/auth_form_input.dart';

class ProposeDateIntroText extends StatelessWidget {
  const ProposeDateIntroText({
    super.key,
    this.matchName = 'Julian',
  });

  final String matchName;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Suggest a thoughtful plan and let $matchName respond when '
      "they're comfortable.",
      textAlign: TextAlign.center,
      style: IntentLoginStyles.onboardingSubtitle.copyWith(
        fontSize: 16,
        height: 1.45,
      ),
    );
  }
}

class ProposeDateMatchSummary extends StatelessWidget {
  const ProposeDateMatchSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _MatchAvatar(initial: 'Y'),
              SizedBox(
                width: 36,
                child: CustomPaint(
                  painter: _DottedLinePainter(),
                  child: const SizedBox(height: 2),
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.7),
                  ),
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: 13,
                  color: AppColors.intentForest.withValues(alpha: 0.85),
                ),
              ),
              SizedBox(
                width: 36,
                child: CustomPaint(
                  painter: _DottedLinePainter(),
                  child: const SizedBox(height: 2),
                ),
              ),
              const _MatchAvatar(initial: 'J'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'You & Julian',
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF8E9B8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 12,
                color: AppColors.intentGold.withValues(alpha: 0.95),
              ),
              const SizedBox(width: 5),
              Text(
                '94% Harmony',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MatchAvatar extends StatelessWidget {
  const _MatchAvatar({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.intentForest,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: IntentLoginStyles.onboardingTitle.copyWith(
          fontSize: 24,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentInputBorder.withValues(alpha: 0.9)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 3.0;
    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum ProposeDateMode {
  inPerson,
  virtual,
}

class ProposeDateDetailsCard extends StatelessWidget {
  const ProposeDateDetailsCard({
    super.key,
    required this.mode,
    required this.onModeChanged,
    required this.messageController,
    required this.placeController,
    required this.dateController,
    required this.timeController,
    required this.dateFocusNode,
    required this.timeFocusNode,
    required this.placeFocusNode,
    required this.messageFocusNode,
    this.messageLength = 0,
    this.onDateTap,
    this.onTimeTap,
  });

  final ProposeDateMode mode;
  final ValueChanged<ProposeDateMode> onModeChanged;
  final TextEditingController messageController;
  final TextEditingController placeController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final FocusNode dateFocusNode;
  final FocusNode timeFocusNode;
  final FocusNode placeFocusNode;
  final FocusNode messageFocusNode;
  final int messageLength;
  final VoidCallback? onDateTap;
  final VoidCallback? onTimeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Date details',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          _ProposeDatePickerField(
            label: 'Date',
            placeholder: 'Choose a date',
            controller: dateController,
            focusNode: dateFocusNode,
            leadingIcon: Icons.calendar_today_outlined,
            onTap: onDateTap,
          ),
          const SizedBox(height: 12),
          _ProposeDatePickerField(
            label: 'Time',
            placeholder: 'Choose a time',
            controller: timeController,
            focusNode: timeFocusNode,
            leadingIcon: Icons.schedule_outlined,
            onTap: onTimeTap,
          ),
          const SizedBox(height: 12),
          Text(
            'Place or virtual option',
            style: IntentLoginStyles.fieldLabel,
          ),
          const SizedBox(height: 8),
          _ProposeDateModeToggle(
            mode: mode,
            onModeChanged: onModeChanged,
          ),
          const SizedBox(height: 12),
          _ProposeDatePlaceField(
            controller: placeController,
            focusNode: placeFocusNode,
            mode: mode,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Short message',
                style: IntentLoginStyles.fieldLabel,
              ),
              const Spacer(),
              Text(
                '$messageLength / 250',
                style: IntentLoginStyles.fieldHint,
              ),
            ],
          ),
          const SizedBox(height: 8),
          _ProposeDateMessageField(
            controller: messageController,
            focusNode: messageFocusNode,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Image.asset(
                AppAssets.rkBrand,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                'Keep it warm and simple',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProposeDateMessageField extends StatefulWidget {
  const _ProposeDateMessageField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<_ProposeDateMessageField> createState() =>
      _ProposeDateMessageFieldState();
}

class _ProposeDateMessageFieldState extends State<_ProposeDateMessageField> {
  static const _borderRadius = 12.0;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(_borderRadius);
    final isFocused = widget.focusNode.hasFocus;
    final borderColor =
        isFocused ? AppColors.intentForest : AppColors.intentInputBorder;
    final borderWidth = isFocused ? 1.2 : 1.0;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: AppShadows.intentInput,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: radius,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.inputFieldLeadingInset,
          12,
          AppSpacing.md,
          12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: AppSpacing.inputFieldIconSize,
              color: AppColors.intentForest,
            ),
            const SizedBox(width: AppSpacing.inputFieldIconToTextGap),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                minLines: 5,
                maxLines: 6,
                maxLength: 250,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) =>
                    null,
                style: IntentLoginStyles.fieldHint.copyWith(
                  color: AppColors.intentText,
                ),
                decoration: InputDecoration(
                  hintText:
                      'I thought this could be a\ncomfortable first plan for us...',
                  hintStyle: IntentLoginStyles.fieldHint,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minHeight: 112,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProposeDatePickerField extends StatelessWidget {
  const _ProposeDatePickerField({
    required this.label,
    required this.placeholder,
    required this.controller,
    required this.focusNode,
    required this.leadingIcon,
    this.onTap,
  });

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData leadingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: IntentLoginStyles.fieldLabel),
        const SizedBox(height: 8),
        AuthFormInput(
          controller: controller,
          focusNode: focusNode,
          hintText: placeholder,
          prefixIcon: leadingIcon,
          readOnly: true,
          onTap: onTap,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              right: AppSpacing.inputFieldTrailingInset,
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: AppSpacing.inputFieldSuffixIconSize,
              color: AppColors.intentForest,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProposeDatePlaceField extends StatelessWidget {
  const _ProposeDatePlaceField({
    required this.controller,
    required this.focusNode,
    required this.mode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ProposeDateMode mode;

  @override
  Widget build(BuildContext context) {
    final hint = mode == ProposeDateMode.virtual
        ? 'e.g. Google Meet, Zoom, or FaceTime'
        : 'Search for a public place';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Place', style: IntentLoginStyles.fieldLabel),
        const SizedBox(height: 8),
        AuthFormInput(
          controller: controller,
          focusNode: focusNode,
          hintText: hint,
          prefixIcon: mode == ProposeDateMode.virtual
              ? Icons.videocam_outlined
              : Icons.location_on_outlined,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              right: AppSpacing.inputFieldTrailingInset,
            ),
            child: Icon(
              Icons.search,
              size: AppSpacing.inputFieldSuffixIconSize,
              color: AppColors.intentForest,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProposeDateModeToggle extends StatelessWidget {
  const _ProposeDateModeToggle({
    required this.mode,
    required this.onModeChanged,
  });

  final ProposeDateMode mode;
  final ValueChanged<ProposeDateMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeChip(
              label: 'In person',
              icon: Icons.location_on_outlined,
              isSelected: mode == ProposeDateMode.inPerson,
              onTap: () => onModeChanged(ProposeDateMode.inPerson),
            ),
          ),
          Expanded(
            child: _ModeChip(
              label: 'Virtual',
              icon: Icons.videocam_outlined,
              isSelected: mode == ProposeDateMode.virtual,
              onTap: () => onModeChanged(ProposeDateMode.virtual),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.intentForest : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.white : AppColors.intentTextSoft,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.intentText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProposeDateSuggestedIdeas extends StatelessWidget {
  const ProposeDateSuggestedIdeas({super.key});

  static const _ideas = [
    _DateIdea(label: 'Coffee', icon: Icons.coffee_outlined),
    _DateIdea(label: 'Walk in a public park', icon: Icons.park_outlined),
    _DateIdea(label: 'Go to a museum', icon: Icons.museum_outlined),
    _DateIdea(label: 'Go to a restaurant', icon: Icons.restaurant_outlined),
    _DateIdea(label: 'Go to a bar', icon: Icons.bar_chart_outlined),
    _DateIdea(label: 'Go to a concert', icon: Icons.music_note_outlined),
    _DateIdea(label: 'Go to a movie', icon: Icons.movie_outlined),
    _DateIdea(label: 'Go to a coffee shop', icon: Icons.coffee_outlined),
    _DateIdea(label: 'Go to a park', icon: Icons.park_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested date ideas',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final idea in _ideas)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.7),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      idea.icon,
                      size: 18,
                      color: AppColors.intentForest,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      idea.label,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.intentText,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DateIdea {
  const _DateIdea({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class ProposeDateSafetyCard extends StatelessWidget {
  const ProposeDateSafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.45),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.intentSegmentFill,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(
                  Icons.shield_outlined,
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
                      'Safety reminder',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'For first dates, choose a public location and keep '
                      'plans inside Intent until both people feel comfortable. '
                      'You can report or update plans anytime.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.intentTextSoft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProposeDateInfoNote extends StatelessWidget {
  const ProposeDateInfoNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Once sent, Julian can accept, suggest a new time, or decline '
              'respectfully.',
              style: IntentLoginStyles.onboardingFooterNote.copyWith(
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProposeDateSendButton extends StatelessWidget {
  const ProposeDateSendButton({
    super.key,
    this.onPressed,
  });

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
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.event_available_outlined,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'SEND DATE PROPOSAL',
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
