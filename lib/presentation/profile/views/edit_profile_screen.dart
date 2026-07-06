import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_2_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_sheet.dart';
import 'package:intent_app/presentation/profile/widgets/edit_profile_sections.dart';
import 'package:intent_app/presentation/profile/widgets/profile_screen_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const _intentions = [
    'Marriage-minded',
    'Long-term relationship',
    'Open to serious connection',
    'Still figuring it out',
  ];

  static const _values = [
    'Family',
    'Honesty',
    'Faith importance',
    'Emotional maturity',
    'Stability',
    'Growth',
    'Communicate',
    'Ambition',
    'Kindness',
    'Respect',
  ];

  static const _selectedValues = {
    'Family',
    'Honesty',
    'Faith importance',
    'Emotional maturity',
    'Stability',
    'Growth',
    'Communicate',
  };

  var _selectedIntention = 0;
  var _religionDealbreaker = false;
  var _familyDealbreaker = true;
  var _smokingDealbreaker = true;
  var _lifestyleDealbreaker = true;
  var _communicationDealbreaker = true;
  var _occupation = 'Product Designer';
  var _height = "5'8\"";
  var _religion = 'Islam';
  var _faithImportance = 'Very Important';
  var _familyGoal = 'I want children';
  var _smoking = 'Non-smoker';
  var _drinking = 'Socially';
  var _fitness = 'Moderately active';
  var _travel = 'Occasional trips';
  var _socialLifestyle = 'Quiet evenings';
  var _workLifeBalance = 'Balanced';
  var _pets = 'Open to pets';
  var _routineStyle = 'Balanced routine';
  var _communication = 'Thoughtful and direct';
  late Set<String> _selectedValueSet;

  static const _occupations = [
    'Product Designer',
    'Student',
    'Healthcare',
    'Technology',
    'Education',
    'Finance',
    'Creative / Arts',
    'Entrepreneur',
    'Other',
  ];

  static const _heights = [
    "4'10\"",
    "4'11\"",
    "5'0\"",
    "5'1\"",
    "5'2\"",
    "5'3\"",
    "5'4\"",
    "5'5\"",
    "5'6\"",
    "5'7\"",
    "5'8\"",
    "5'9\"",
    "5'10\"",
    "5'11\"",
    "6'0\"",
    "6'1\"",
    "6'2\"",
    "6'3\"",
    "6'4\"",
  ];

  static const _faithImportanceOptions = [
    'Very Important',
    'Somewhat Important',
    'Not Very Important',
    "Doesn't Matter",
  ];

  static const _familyGoalOptions = [
    'I want children',
    "I don't want children",
    'Open to children',
    'Already have children',
    'Not sure yet',
    'Prefer not to say',
  ];

  static const _smokingOptions = [
    'Non-smoker',
    'Occasionally',
    'Regular smoker',
    'Trying to quit',
  ];

  static const _drinkingOptions = [
    'Never',
    'Socially',
    'Regularly',
    'Prefer not to say',
  ];

  static const _fitnessOptions = [
    'Sedentary',
    'Lightly active',
    'Moderately active',
    'Very active',
  ];

  static const _travelOptions = [
    'Rarely travel',
    'Occasional trips',
    'Frequent traveler',
    'Digital nomad',
  ];

  static const _socialLifestyleOptions = [
    'Quiet evenings',
    'Active social life',
    'Quiet evenings + meaningful outings',
    'Balanced social life',
  ];

  static const _workLifeBalanceOptions = [
    'Work-focused',
    'Balanced',
    'Life-focused',
  ];

  static const _petsOptions = [
    'No pets',
    'Have pets',
    'Open to pets',
    'Allergic to pets',
  ];

  static const _routineStyleOptions = [
    'Early bird',
    'Night owl',
    'Balanced routine',
    'Flexible schedule',
  ];

  static const _communicationOptions = [
    'Thoughtful and direct',
    'Frequent texter',
    'Phone calls preferred',
    'In-person first',
  ];

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: title,
      options: options,
    );
    if (selected != null && mounted) {
      setState(() => onSelected(selected));
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedValueSet = Set<String>.from(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditProfileSaveButton(
              onPressed: () => context.go(AppRoutes.profile),
            ),
            const SizedBox(height: 14),
            Center(
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 14,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      pinnedFooterExtent: 96,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileScreenHeader(
              title: 'Edit Profile',
              trailingIcon: Icons.verified_outlined,
              onBack: () => context.pop(),
            ),
            const SizedBox(height: 16),
            const EditProfilePhotosCard(),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.person_outline,
                    title: 'Basic Details',
                  ),
                  const SizedBox(height: 14),
                  EditProfileFieldRow(
                    label: 'Occupation',
                    icon: Icons.work_outline,
                    value: _occupation,
                    onTap: () => _pickOption(
                      title: 'Occupation',
                      options: _occupations,
                      onSelected: (value) => _occupation = value,
                    ),
                  ),
                  const SizedBox(height: 14),
                  EditProfileFieldRow(
                    label: 'Height',
                    icon: Icons.straighten_outlined,
                    value: _height,
                    onTap: () => _pickOption(
                      title: 'Height',
                      options: _heights,
                      onSelected: (value) => _height = value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.favorite_border,
                    title: 'Relationship Intention',
                  ),
                  const SizedBox(height: 14),
                  for (var i = 0; i < _intentions.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
                    EditProfileIntentionOption(
                      label: _intentions[i],
                      isSelected: _selectedIntention == i,
                      onTap: () => setState(() => _selectedIntention = i),
                    ),
                  ],
                  const SizedBox(height: 12),
                  const EditProfileFooterNote(
                    text:
                        'This helps us match you with people who want '
                        'similar commitment.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.auto_awesome_outlined,
                    title: 'Religion & Beliefs',
                  ),
                  const SizedBox(height: 14),
                  EditProfileDropdownField(
                    label: 'Religion / Belief',
                    value: _religion,
                    onTap: () => _pickOption(
                      title: 'Religion / Belief',
                      options: Onboarding2Notifier.religionBeliefs,
                      onSelected: (value) => _religion = value,
                    ),
                  ),
                  const SizedBox(height: 14),
                  EditProfileDropdownField(
                    label: 'Faith importance',
                    value: _faithImportance,
                    onTap: () => _pickOption(
                      title: 'Faith importance',
                      options: _faithImportanceOptions,
                      onSelected: (value) => _faithImportance = value,
                    ),
                  ),
                  const SizedBox(height: 12),
                  EditProfileDealbreakerToggle(
                    label: 'Make this a dealbreaker',
                    isOn: _religionDealbreaker,
                    onChanged: (value) =>
                        setState(() => _religionDealbreaker = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.people_outline,
                    title: 'Family Goals',
                  ),
                  const SizedBox(height: 14),
                  EditProfileDropdownField(
                    label: 'Select your family goal',
                    value: _familyGoal,
                    onTap: () => _pickOption(
                      title: 'Family goal',
                      options: _familyGoalOptions,
                      onSelected: (value) => _familyGoal = value,
                    ),
                  ),
                  const SizedBox(height: 12),
                  EditProfileDealbreakerToggle(
                    label: 'Make this a dealbreaker',
                    isOn: _familyDealbreaker,
                    onChanged: (value) =>
                        setState(() => _familyDealbreaker = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.landscape_outlined,
                    title: 'Lifestyle',
                  ),
                  const SizedBox(height: 14),
                  EditProfileLifestyleRow(
                    icon: Icons.smoke_free_outlined,
                    label: 'Smoking',
                    value: _smoking,
                    onTap: () => _pickOption(
                      title: 'Smoking',
                      options: _smokingOptions,
                      onSelected: (value) => _smoking = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.local_bar_outlined,
                    label: 'Drinking',
                    value: _drinking,
                    onTap: () => _pickOption(
                      title: 'Drinking',
                      options: _drinkingOptions,
                      onSelected: (value) => _drinking = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.fitness_center_outlined,
                    label: 'Fitness',
                    value: _fitness,
                    onTap: () => _pickOption(
                      title: 'Fitness',
                      options: _fitnessOptions,
                      onSelected: (value) => _fitness = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.flight_outlined,
                    label: 'Travel',
                    value: _travel,
                    onTap: () => _pickOption(
                      title: 'Travel',
                      options: _travelOptions,
                      onSelected: (value) => _travel = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.nightlife_outlined,
                    label: 'Social lifestyle',
                    value: _socialLifestyle,
                    onTap: () => _pickOption(
                      title: 'Social lifestyle',
                      options: _socialLifestyleOptions,
                      onSelected: (value) => _socialLifestyle = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.balance_outlined,
                    label: 'Work-life balance',
                    value: _workLifeBalance,
                    onTap: () => _pickOption(
                      title: 'Work-life balance',
                      options: _workLifeBalanceOptions,
                      onSelected: (value) => _workLifeBalance = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.pets_outlined,
                    label: 'Pets',
                    value: _pets,
                    onTap: () => _pickOption(
                      title: 'Pets',
                      options: _petsOptions,
                      onSelected: (value) => _pets = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.schedule_outlined,
                    label: 'Routine style',
                    value: _routineStyle,
                    onTap: () => _pickOption(
                      title: 'Routine style',
                      options: _routineStyleOptions,
                      onSelected: (value) => _routineStyle = value,
                    ),
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.chat_bubble_outline,
                    label: 'Communication',
                    value: _communication,
                    showDivider: false,
                    onTap: () => _pickOption(
                      title: 'Communication',
                      options: _communicationOptions,
                      onSelected: (value) => _communication = value,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const EditProfileFooterNote(
                    text:
                        'These details help others understand daily '
                        'compatibility beyond surface-level attraction.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.star_outline,
                    title: 'Values',
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final value in _values)
                        EditProfileValueChip(
                          label: value,
                          isSelected: _selectedValueSet.contains(value),
                          onTap: () => setState(() {
                            if (_selectedValueSet.contains(value)) {
                              _selectedValueSet.remove(value);
                            } else {
                              _selectedValueSet.add(value);
                            }
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const EditProfileFooterNote(
                    text: 'Select the values that matter most to you.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            EditProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const EditProfileSectionHeader(
                    icon: Icons.adjust_outlined,
                    title: 'Dealbreakers',
                  ),
                  const SizedBox(height: 14),
                  const EditProfileDealbreakerSummaryRow(
                    icon: Icons.favorite_border,
                    label: 'Relationship intention',
                    value: 'Marriage-minded',
                    showValueStar: true,
                  ),
                  const EditProfileDealbreakerSummaryRow(
                    icon: Icons.blur_on,
                    label: 'Religion / beliefs',
                    value: 'Compatible',
                  ),
                  const EditProfileDealbreakerSummaryRow(
                    icon: Icons.circle_outlined,
                    label: 'Children / family goals',
                    value: 'Wants children',
                    showDivider: false,
                  ),
                  const SizedBox(height: 14),
                  EditProfileDealbreakerToggle(
                    icon: Icons.star_outline,
                    label: 'Smoking (Dealbreaker)',
                    isOn: _smokingDealbreaker,
                    onChanged: (value) =>
                        setState(() => _smokingDealbreaker = value),
                  ),
                  const SizedBox(height: 10),
                  EditProfileDealbreakerToggle(
                    icon: Icons.nightlife_outlined,
                    label: 'Lifestyle habits (Important)',
                    isOn: _lifestyleDealbreaker,
                    onChanged: (value) =>
                        setState(() => _lifestyleDealbreaker = value),
                  ),
                  const SizedBox(height: 10),
                  EditProfileDealbreakerToggle(
                    icon: Icons.chat_bubble_outline,
                    label: 'Communication consistency (Important)',
                    isOn: _communicationDealbreaker,
                    onChanged: (value) =>
                        setState(() => _communicationDealbreaker = value),
                  ),
                  const SizedBox(height: 12),
                  const EditProfileFooterNote(
                    text:
                        'Dealbreakers help reflect and protect your '
                        'strongest relationship boundaries.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const EditProfilePhotoPrivacyCard(),
          ],
        ),
      ),
    );
  }
}
