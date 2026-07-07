import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/chat/models/date_proposal.dart';
import 'package:intent_app/presentation/dates/models/date_hub_entry.dart';

const List<DateHubEntry> datesSampleEntries = [
  DateHubEntry(
    id: 'pending-1',
    matchName: 'Jordan',
    matchInitial: 'J',
    avatarColor: AppColors.intentForest,
    initialColor: AppColors.white,
    section: DateHubSection.pending,
    headline: 'Coffee walk at Riverside Park',
    subtitle: 'Saturday, Mar 15 · 4:30 PM',
    statusLabel: 'Awaiting your response',
    proposalStatus: DateProposalStatus.pending,
    detailRoute: AppRoutes.dateProposed,
    needsAction: true,
  ),
  DateHubEntry(
    id: 'pending-2',
    matchName: 'Mia',
    matchInitial: 'M',
    avatarColor: AppColors.intentGoldMuted,
    initialColor: AppColors.intentText,
    section: DateHubSection.pending,
    headline: 'Dinner at Harbor Bistro',
    subtitle: 'Sent yesterday',
    statusLabel: 'Awaiting response',
    proposalStatus: DateProposalStatus.pending,
    detailRoute: AppRoutes.dateProposed,
    isSentByMe: true,
  ),
  DateHubEntry(
    id: 'upcoming-1',
    matchName: 'Jordan',
    matchInitial: 'J',
    avatarColor: AppColors.intentForest,
    initialColor: AppColors.white,
    section: DateHubSection.upcoming,
    headline: 'Coffee walk at Riverside Park',
    subtitle: 'Saturday, Mar 15 · 4:30 PM · In person',
    statusLabel: 'Confirmed',
    proposalStatus: DateProposalStatus.confirmed,
    detailRoute: AppRoutes.dateSetConfirmed,
  ),
  DateHubEntry(
    id: 'past-1',
    matchName: 'Alex',
    matchInitial: 'A',
    avatarColor: AppColors.intentCreamDeep,
    initialColor: AppColors.intentForest,
    section: DateHubSection.past,
    headline: 'Gallery visit downtown',
    subtitle: 'Last Sunday · Photo unlock available',
    statusLabel: 'Completed',
    proposalStatus: DateProposalStatus.confirmed,
    detailRoute: AppRoutes.dateFeedback,
    needsAction: true,
  ),
];

int get datesPendingActionCount => datesSampleEntries
    .where(
      (entry) =>
          entry.section == DateHubSection.pending && entry.needsAction,
    )
    .length;
