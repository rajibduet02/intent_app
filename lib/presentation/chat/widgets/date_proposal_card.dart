import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/chat/models/date_proposal.dart';

class DateProposalCard extends StatelessWidget {
  const DateProposalCard({
    super.key,
    required this.proposal,
    this.onTap,
    this.onAccept,
    this.onSuggestNewTime,
    this.onDecline,
  });

  final DateProposal proposal;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onSuggestNewTime;
  final VoidCallback? onDecline;

  bool get _showReceiverActions =>
      !proposal.isSentByMe && proposal.status == DateProposalStatus.pending;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
              boxShadow: AppShadows.intentInput,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.intentForest.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.event_available_outlined,
                          size: 20,
                          color: AppColors.intentForest,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              proposal.headline,
                              style: IntentLoginStyles.onboardingCardFieldLabel
                                  .copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              proposal.statusLabel,
                              style: IntentLoginStyles.onboardingSubtitle
                                  .copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _statusColor(proposal.status),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (onTap != null)
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.intentTextSoft,
                        ),
                    ],
                  ),
                  if (proposal.dateIdea != null &&
                      proposal.dateIdea!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      proposal.dateIdea!,
                      style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ],
                  if (proposal.dateTimeSummary.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      proposal.dateTimeSummary,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (proposal.place != null && proposal.place!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.intentTextSoft,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            proposal.place!,
                            style: IntentLoginStyles.onboardingSubtitle
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (_showReceiverActions) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _ProposalActionButton(
                            label: 'Accept',
                            style: _ProposalActionStyle.primary,
                            onTap: onAccept,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _ProposalActionButton(
                            label: 'Suggest New Time',
                            style: _ProposalActionStyle.outlined,
                            onTap: onSuggestNewTime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _ProposalActionButton(
                      label: 'Decline',
                      style: _ProposalActionStyle.text,
                      onTap: onDecline,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(DateProposalStatus status) {
    return switch (status) {
      DateProposalStatus.pending => AppColors.intentGold,
      DateProposalStatus.accepted => AppColors.intentForest,
      DateProposalStatus.counterProposed => AppColors.intentForest,
      DateProposalStatus.declined => AppColors.danger,
      DateProposalStatus.confirmed => AppColors.intentForest,
    };
  }
}

enum _ProposalActionStyle { primary, outlined, text }

class _ProposalActionButton extends StatelessWidget {
  const _ProposalActionButton({
    required this.label,
    required this.style,
    this.onTap,
  });

  final String label;
  final _ProposalActionStyle style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case _ProposalActionStyle.primary:
        return SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.intentForest,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        );
      case _ProposalActionStyle.outlined:
        return SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.intentInputBorder.withValues(alpha: 0.8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      case _ProposalActionStyle.text:
        return TextButton(
          onPressed: onTap,
          child: Text(
            label,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.danger,
            ),
          ),
        );
    }
  }
}
