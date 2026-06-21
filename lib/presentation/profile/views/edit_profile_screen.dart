import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
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
  late Set<String> _selectedValueSet;

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
                children: const [
                  EditProfileSectionHeader(
                    icon: Icons.person_outline,
                    title: 'Basic Details',
                  ),
                  SizedBox(height: 14),
                  EditProfileFieldRow(
                    label: 'Occupation',
                    icon: Icons.work_outline,
                    value: 'Product Designer',
                  ),
                  SizedBox(height: 14),
                  EditProfileFieldRow(
                    label: 'Height',
                    icon: Icons.straighten_outlined,
                    value: "5'8\"",
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
                  const EditProfileDropdownField(
                    label: 'Religion / Belief',
                    value: 'Islam',
                  ),
                  const SizedBox(height: 14),
                  const EditProfileDropdownField(
                    label: 'Faith importance',
                    value: 'Very Important',
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
                  const EditProfileDropdownField(
                    label: 'Select your family goal',
                    value: 'I want children',
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
                children: const [
                  EditProfileSectionHeader(
                    icon: Icons.landscape_outlined,
                    title: 'Lifestyle',
                  ),
                  SizedBox(height: 14),
                  EditProfileLifestyleRow(
                    icon: Icons.smoke_free_outlined,
                    label: 'Smoking',
                    value: 'Non-smoker',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.local_bar_outlined,
                    label: 'Drinking',
                    value: 'Socially',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.fitness_center_outlined,
                    label: 'Fitness',
                    value: 'Moderately active',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.flight_outlined,
                    label: 'Travel',
                    value: 'Occasional trips',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.nightlife_outlined,
                    label: 'Social lifestyle',
                    value: 'Quiet evenings',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.balance_outlined,
                    label: 'Work-life balance',
                    value: 'Balanced',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.pets_outlined,
                    label: 'Pets',
                    value: 'Open to pets',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.schedule_outlined,
                    label: 'Routine style',
                    value: 'Balanced routine',
                  ),
                  EditProfileLifestyleRow(
                    icon: Icons.chat_bubble_outline,
                    label: 'Communication',
                    value: 'Thoughtful and direct',
                    showDivider: false,
                  ),
                  SizedBox(height: 12),
                  EditProfileFooterNote(
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
