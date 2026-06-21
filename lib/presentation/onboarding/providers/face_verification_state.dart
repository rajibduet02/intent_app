enum FaceScanPhase {
  idle,
  starting,
  scanning,
  verifying,
  completed,
}

class FaceVerificationState {
  const FaceVerificationState({
    required this.phase,
    required this.scanProgress,
    required this.selfiePath,
    required this.statusLabel,
    required this.isLoading,
  });

  final FaceScanPhase phase;
  final double scanProgress;
  final String? selfiePath;
  final String statusLabel;
  final bool isLoading;

  factory FaceVerificationState.initial() {
    return const FaceVerificationState(
      phase: FaceScanPhase.idle,
      scanProgress: 0,
      selfiePath: null,
      statusLabel: 'ALIGN FACE',
      isLoading: false,
    );
  }

  bool get isScanActive =>
      phase == FaceScanPhase.starting ||
      phase == FaceScanPhase.scanning ||
      phase == FaceScanPhase.verifying;

  bool get canStartScan =>
      phase == FaceScanPhase.idle || phase == FaceScanPhase.completed;

  bool get canContinue => phase == FaceScanPhase.completed;

  FaceVerificationState copyWith({
    FaceScanPhase? phase,
    double? scanProgress,
    String? selfiePath,
    String? statusLabel,
    bool? isLoading,
    bool clearSelfie = false,
    bool resetScan = false,
  }) {
    return FaceVerificationState(
      phase: phase ?? this.phase,
      scanProgress: resetScan ? 0 : scanProgress ?? this.scanProgress,
      selfiePath: clearSelfie ? null : selfiePath ?? this.selfiePath,
      statusLabel: statusLabel ?? this.statusLabel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
