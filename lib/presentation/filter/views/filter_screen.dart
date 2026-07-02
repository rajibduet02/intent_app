import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/filter/widgets/filter_header.dart';
import 'package:intent_app/presentation/filter/widgets/filter_sections.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  static const _defaultDistance = 25.0;
  static const _defaultAgeRange = RangeValues(25, 38);
  static const _defaultMinCompatibility = 70.0;

  static const _intentionOptions = [
    'Serious relationship',
    'Marriage-minded',
    'Long-term dating',
    'Intentional connection',
  ];

  double _distance = _defaultDistance;
  RangeValues _ageRange = _defaultAgeRange;
  final Set<String> _selectedIntentions = {};
  double _minCompatibility = _defaultMinCompatibility;
  bool _compatibilityFirst = true;
  bool _verifiedOnly = false;
  bool _recentlyActive = true;

  int get _activeFilterCount {
    var count = 0;
    if (_distance != _defaultDistance) count++;
    if (_ageRange != _defaultAgeRange) count++;
    if (_selectedIntentions.isNotEmpty) count++;
    if (_minCompatibility != _defaultMinCompatibility) count++;
    if (!_compatibilityFirst) count++;
    if (_verifiedOnly) count++;
    if (!_recentlyActive) count++;
    return count;
  }

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.discover);
    }
  }

  void _resetFilters() {
    setState(() {
      _distance = _defaultDistance;
      _ageRange = _defaultAgeRange;
      _selectedIntentions.clear();
      _minCompatibility = _defaultMinCompatibility;
      _compatibilityFirst = true;
      _verifiedOnly = false;
      _recentlyActive = true;
    });
  }

  void _toggleIntention(String intention) {
    setState(() {
      if (_selectedIntentions.contains(intention)) {
        _selectedIntentions.remove(intention);
      } else {
        _selectedIntentions.add(intention);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilterHeader(onBack: () => _onBack(context)),
            const SizedBox(height: 16),
            FilterIntroSection(activeFilterCount: _activeFilterCount),
            const SizedBox(height: 20),
            FilterSectionCard(
              title: 'Location & age',
              subtitle: 'Set the basics for who appears in your feed.',
              children: [
                FilterSliderRow(
                  label: 'Maximum distance',
                  valueLabel: '${_distance.round()} mi',
                  value: _distance,
                  min: 5,
                  max: 100,
                  divisions: 19,
                  onChanged: (value) => setState(() => _distance = value),
                ),
                const SizedBox(height: 8),
                FilterRangeSliderRow(
                  label: 'Age range',
                  valueLabel:
                      '${_ageRange.start.round()} – ${_ageRange.end.round()}',
                  values: _ageRange,
                  min: 21,
                  max: 55,
                  onChanged: (values) => setState(() => _ageRange = values),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilterSectionCard(
              title: 'Relationship intention',
              subtitle: 'Show people aligned with what you\'re looking for.',
              children: [
                FilterChipGroup(
                  options: _intentionOptions,
                  selected: _selectedIntentions,
                  onToggle: _toggleIntention,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilterSectionCard(
              title: 'Compatibility',
              subtitle: 'Keep Intent\'s values-first matching at the center.',
              children: [
                FilterSliderRow(
                  label: 'Minimum compatibility',
                  valueLabel: '${_minCompatibility.round()}%',
                  value: _minCompatibility,
                  min: 50,
                  max: 95,
                  divisions: 9,
                  onChanged: (value) =>
                      setState(() => _minCompatibility = value),
                ),
                const SizedBox(height: 4),
                FilterToggleRow(
                  icon: Icons.favorite_border,
                  label: 'Show compatibility first',
                  subtitle:
                      'Prioritize stronger alignment over recency.',
                  value: _compatibilityFirst,
                  onChanged: (value) =>
                      setState(() => _compatibilityFirst = value),
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilterSectionCard(
              title: 'Profile preferences',
              children: [
                FilterToggleRow(
                  icon: Icons.verified_user_outlined,
                  label: 'Verified profiles only',
                  subtitle: 'See members who completed ID verification.',
                  value: _verifiedOnly,
                  onChanged: (value) => setState(() => _verifiedOnly = value),
                ),
                FilterToggleRow(
                  icon: Icons.schedule,
                  label: 'Recently active',
                  subtitle: 'Prioritize people active in the last 7 days.',
                  value: _recentlyActive,
                  onChanged: (value) => setState(() => _recentlyActive = value),
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 14),
            const FilterPrivacyNote(),
            const SizedBox(height: 20),
            FilterApplyButton(
              onPressed: () => _onBack(context),
            ),
            const SizedBox(height: 14),
            FilterResetLink(onTap: _resetFilters),
          ],
        ),
      ),
    );
  }
}
