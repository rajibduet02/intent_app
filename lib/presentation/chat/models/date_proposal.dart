enum DateProposalStatus {
  pending,
  accepted,
  counterProposed,
  declined,
  confirmed,
}

class DateProposal {
  const DateProposal({
    this.dateIdea,
    this.place,
    this.date,
    this.time,
    this.message,
    this.modeLabel = 'In person',
    this.status = DateProposalStatus.pending,
    this.isSentByMe = false,
  });

  final String? dateIdea;
  final String? place;
  final String? date;
  final String? time;
  final String? message;
  final String modeLabel;
  final DateProposalStatus status;
  final bool isSentByMe;

  String get headline => isSentByMe ? 'Date proposal sent' : 'Date proposal received';

  String get statusLabel => switch (status) {
        DateProposalStatus.pending => 'Pending',
        DateProposalStatus.accepted => 'Accepted',
        DateProposalStatus.counterProposed => 'New time suggested',
        DateProposalStatus.declined => 'Declined',
        DateProposalStatus.confirmed => 'Confirmed',
      };

  String get dateTimeSummary {
    final parts = <String>[];
    if (date != null && date!.isNotEmpty) {
      parts.add(date!);
    }
    if (time != null && time!.isNotEmpty) {
      parts.add(time!);
    }
    return parts.join(', ');
  }

  DateProposal copyWith({
    String? dateIdea,
    String? place,
    String? date,
    String? time,
    String? message,
    String? modeLabel,
    DateProposalStatus? status,
    bool? isSentByMe,
  }) {
    return DateProposal(
      dateIdea: dateIdea ?? this.dateIdea,
      place: place ?? this.place,
      date: date ?? this.date,
      time: time ?? this.time,
      message: message ?? this.message,
      modeLabel: modeLabel ?? this.modeLabel,
      status: status ?? this.status,
      isSentByMe: isSentByMe ?? this.isSentByMe,
    );
  }
}
