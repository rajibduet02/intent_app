import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/chat/models/date_proposal.dart';
import 'package:intent_app/presentation/dates/models/date_hub_entry.dart';

class DateHubCard extends StatelessWidget {
  const DateHubCard({
    super.key,
    required this.entry,
    this.onTap,
  });

  final DateHubEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(entry.proposalStatus, entry.needsAction);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: entry.needsAction
                  ? AppColors.intentGold.withValues(alpha: 0.45)
                  : AppColors.intentInputBorder.withValues(alpha: 0.45),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: entry.avatarColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  entry.matchInitial,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: entry.initialColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.matchName,
                            style: IntentLoginStyles.onboardingCardFieldLabel
                                .copyWith(fontSize: 14),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            entry.statusLabel,
                            style: IntentLoginStyles.onboardingSubtitle
                                .copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.headline,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.subtitle,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 11,
                        color: AppColors.intentTextSoft,
                        height: 1.35,
                      ),
                    ),
                    if (entry.isSentByMe) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Proposal sent by you',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.intentForest,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.intentTextSoft.withValues(alpha: 0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(DateProposalStatus status, bool needsAction) {
    if (needsAction) {
      return AppColors.intentNotificationDot;
    }
    return switch (status) {
      DateProposalStatus.pending => AppColors.intentGold,
      DateProposalStatus.accepted ||
      DateProposalStatus.confirmed =>
        AppColors.success,
      DateProposalStatus.counterProposed => AppColors.accentBlue,
      DateProposalStatus.declined => AppColors.intentTextSoft,
    };
  }
}
