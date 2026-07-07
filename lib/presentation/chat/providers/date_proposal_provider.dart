import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/presentation/chat/models/date_proposal.dart';

class DateProposalState {
  const DateProposalState({this.proposal});

  final DateProposal? proposal;

  static DateProposalState initial() => DateProposalState(
        proposal: DateProposal(
          dateIdea: 'Coffee',
          place: 'Bloom Café, Downtown',
          date: 'Saturday, June 21',
          time: '7:00 PM',
          message: 'Would love to meet for coffee and continue our conversation.',
          status: DateProposalStatus.pending,
          isSentByMe: false,
        ),
      );

  DateProposalState copyWith({DateProposal? proposal, bool clearProposal = false}) {
    return DateProposalState(
      proposal: clearProposal ? null : (proposal ?? this.proposal),
    );
  }
}

final dateProposalProvider =
    NotifierProvider<DateProposalNotifier, DateProposalState>(
  DateProposalNotifier.new,
);

class DateProposalNotifier extends Notifier<DateProposalState> {
  @override
  DateProposalState build() => DateProposalState.initial();

  void sendProposal({
    required String? dateIdea,
    required String? place,
    required String? date,
    required String? time,
    required String? message,
    required String modeLabel,
    bool isCounterProposal = false,
  }) {
    state = state.copyWith(
      proposal: DateProposal(
        dateIdea: dateIdea,
        place: place,
        date: date,
        time: time,
        message: message,
        modeLabel: modeLabel,
        status: isCounterProposal
            ? DateProposalStatus.counterProposed
            : DateProposalStatus.pending,
        isSentByMe: true,
      ),
    );
  }

  void acceptProposal() {
    final current = state.proposal;
    if (current == null) {
      return;
    }
    state = state.copyWith(
      proposal: current.copyWith(status: DateProposalStatus.accepted),
    );
  }

  void confirmProposal() {
    final current = state.proposal;
    if (current == null) {
      return;
    }
    state = state.copyWith(
      proposal: current.copyWith(status: DateProposalStatus.confirmed),
    );
  }

  void declineProposal() {
    final current = state.proposal;
    if (current == null) {
      return;
    }
    state = state.copyWith(
      proposal: current.copyWith(status: DateProposalStatus.declined),
    );
  }

  void clearProposal() {
    state = state.copyWith(clearProposal: true);
  }
}
