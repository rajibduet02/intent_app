import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/validators.dart';
import 'package:intent_app/presentation/onboarding/providers/profile_basics_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_gender_selector.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_labeled_field.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class ProfileBasicsScreen extends ConsumerStatefulWidget {
  const ProfileBasicsScreen({super.key});

  @override
  ConsumerState<ProfileBasicsScreen> createState() => _ProfileBasicsScreenState();
}

class _ProfileBasicsScreenState extends ConsumerState<ProfileBasicsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _occupationFocus = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _ageController.dispose();
    _occupationController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _dobFocus.dispose();
    _ageFocus.dispose();
    _occupationFocus.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 25),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.intentForest,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.intentText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null || !mounted) {
      return;
    }
    ref.read(profileBasicsProvider.notifier).setDateOfBirth(picked);
    final month = picked.month.toString().padLeft(2, '0');
    final day = picked.day.toString().padLeft(2, '0');
    _dobController.text = '$month/$day/${picked.year}';
    final age = ref.read(profileBasicsProvider).age;
    _ageController.text = age?.toString() ?? '';
  }

  Future<void> _pickOccupation() async {
    final occupations = ProfileBasicsNotifier.occupations;
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final maxHeight = MediaQuery.sizeOf(context).height * 0.55;
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select occupation',
                  textAlign: TextAlign.center,
                  style: IntentLoginStyles.fieldLabel,
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: occupations.length,
                    itemBuilder: (context, index) {
                      final item = occupations[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item,
                          style: IntentLoginStyles.fieldHint.copyWith(
                            color: AppColors.intentText,
                          ),
                        ),
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (selected == null || !mounted) {
      return;
    }
    ref.read(profileBasicsProvider.notifier).setOccupation(selected);
    _occupationController.text = selected;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(profileBasicsProvider.notifier);
    final isLoading = ref.watch(profileBasicsProvider.select((s) => s.isLoading));

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          isLoading: isLoading,
          onPressed: () => unawaited(
            notifier.submit(
              formKey: _formKey,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
            ),
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _onboardingPinnedFooterHeight,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IntentBackButton(onPressed: notifier.onBack),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                "Let's start with the \nbasics",
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingTitle.copyWith(height: 1.2),
              ),
              const SizedBox(height: 12),
              Text(
                'This information helps us build your intentional profile.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle,
              ),
              const SizedBox(height: AppSpacing.lg),
              OnboardingLabeledField(
                label: 'First Name',
                hintText: 'Enter your first name',
                prefixIcon: Icons.person_outline,
                controller: _firstNameController,
                focusNode: _firstNameFocus,
                validator: (v) => Validators.requiredField(v, fieldName: 'First name'),
              ),
              const SizedBox(height: 16),
              OnboardingLabeledField(
                label: 'Last Name',
                hintText: 'Enter your last name',
                prefixIcon: Icons.person_outline,
                controller: _lastNameController,
                focusNode: _lastNameFocus,
                validator: (v) => Validators.requiredField(v, fieldName: 'Last name'),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: OnboardingLabeledField(
                      label: 'Date of Birth',
                      hintText: 'mm/dd/yyyy',
                      prefixIcon: Icons.calendar_today_outlined,
                      controller: _dobController,
                      focusNode: _dobFocus,
                      readOnly: true,
                      onTap: _pickDateOfBirth,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: OnboardingLabeledField(
                      label: 'Age',
                      hintText: '—',
                      prefixIcon: Icons.lock_outline,
                      controller: _ageController,
                      focusNode: _ageFocus,
                      readOnly: true,
                      fillColor: AppColors.intentSegmentFill,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Displayed to connections, exact DOB stays private.',
                style: IntentLoginStyles.onboardingHelper,
              ),
              const SizedBox(height: 16),
              const OnboardingGenderSelector(),
              const SizedBox(height: 16),
              OnboardingLabeledField(
                label: 'Occupation',
                hintText: 'Select occupation',
                prefixIcon: Icons.work_outline,
                controller: _occupationController,
                focusNode: _occupationFocus,
                readOnly: true,
                onTap: _pickOccupation,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.intentForest,
                    size: 24,
                  ),
                  onPressed: _pickOccupation,
                ),
              ),
              const SizedBox(height: 24),
              const OnboardingPrivacyNote(),
            ],
          ),
        ),
      ),
    );
  }
}

const double _onboardingPinnedFooterHeight = 72;
