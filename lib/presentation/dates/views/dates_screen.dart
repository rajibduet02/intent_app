import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/dates/data/dates_sample_data.dart';
import 'package:intent_app/presentation/dates/models/date_hub_entry.dart';
import 'package:intent_app/presentation/dates/widgets/date_hub_card.dart';
import 'package:intent_app/presentation/dates/widgets/dates_filter_chips.dart';
import 'package:intent_app/presentation/dates/widgets/dates_header.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';

class DatesScreen extends StatefulWidget {
  const DatesScreen({super.key});

  @override
  State<DatesScreen> createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  DateHubSection _selectedSection = DateHubSection.pending;

  List<DateHubEntry> get _filteredEntries => datesSampleEntries
      .where((entry) => entry.section == _selectedSection)
      .toList();

  int _countFor(DateHubSection section) =>
      datesSampleEntries.where((entry) => entry.section == section).length;

  @override
  Widget build(BuildContext context) {
    final entries = _filteredEntries;

    return DiscoverScaffold(
      topBar: const DatesHeader(),
      bottomNavigationBar: DiscoverBottomNav(
        selectedTab: CustomBottomNavTab.dates,
        onTabSelected: (tab) => navigateCustomBottomNavTab(context, tab),
        messagesBadgeCount: 5,
        datesBadgeCount: datesPendingActionCount,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 6),
            DatesFilterChips(
              selectedSection: _selectedSection,
              onSectionSelected: (section) =>
                  setState(() => _selectedSection = section),
              pendingCount: _countFor(DateHubSection.pending),
              upcomingCount: _countFor(DateHubSection.upcoming),
              pastCount: _countFor(DateHubSection.past),
            ),
            const SizedBox(height: 16),
            if (entries.isEmpty)
              _EmptySection(section: _selectedSection)
            else ...[
              for (var i = 0; i < entries.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                DateHubCard(
                  entry: entries[i],
                  onTap: () => context.push(entries[i].detailRoute),
                ),
              ],
            ],
            const SizedBox(height: 16),
            const _DatesHintCard(),
          ],
        ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({required this.section});

  final DateHubSection section;

  @override
  Widget build(BuildContext context) {
    final message = switch (section) {
      DateHubSection.pending =>
        'No pending proposals right now. Start one from a conversation.',
      DateHubSection.upcoming =>
        'No upcoming dates yet. Accept a proposal to see it here.',
      DateHubSection.past =>
        'Past dates and follow-ups will appear here after you meet.',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: IntentLoginStyles.onboardingSubtitle.copyWith(height: 1.45),
      ),
    );
  }
}

class _DatesHintCard extends StatelessWidget {
  const _DatesHintCard();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 18,
              color: AppColors.intentForest.withValues(alpha: 0.9),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Propose a date from Messages when you are ready to meet. '
                'Status updates will show here.',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
