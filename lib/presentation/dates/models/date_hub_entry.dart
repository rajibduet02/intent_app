import 'package:flutter/material.dart';

import 'package:intent_app/presentation/chat/models/date_proposal.dart';

enum DateHubSection {
  pending,
  upcoming,
  past,
}

class DateHubEntry {
  const DateHubEntry({
    required this.id,
    required this.matchName,
    required this.matchInitial,
    required this.avatarColor,
    required this.initialColor,
    required this.section,
    required this.headline,
    required this.subtitle,
    required this.statusLabel,
    required this.proposalStatus,
    required this.detailRoute,
    this.needsAction = false,
    this.isSentByMe = false,
  });

  final String id;
  final String matchName;
  final String matchInitial;
  final Color avatarColor;
  final Color initialColor;
  final DateHubSection section;
  final String headline;
  final String subtitle;
  final String statusLabel;
  final DateProposalStatus proposalStatus;
  final String detailRoute;
  final bool needsAction;
  final bool isSentByMe;
}
