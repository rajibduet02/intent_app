import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_progress_provider.dart';

/// Syncs [onboardingProgressProvider] after the first frame.
class OnboardingProgressSync extends ConsumerStatefulWidget {
  const OnboardingProgressSync({
    super.key,
    required this.phase,
    required this.questionIndex,
    this.questionTotalOverride,
    required this.child,
  });

  final OnboardingPhase phase;
  final int questionIndex;
  final int? questionTotalOverride;
  final Widget child;

  @override
  ConsumerState<OnboardingProgressSync> createState() =>
      _OnboardingProgressSyncState();
}

class _OnboardingProgressSyncState
    extends ConsumerState<OnboardingProgressSync> {
  void _sync() {
    ref.read(onboardingProgressProvider.notifier).sync(
          phase: widget.phase,
          questionIndex: widget.questionIndex,
          questionTotalOverride: widget.questionTotalOverride,
        );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void didUpdateWidget(covariant OnboardingProgressSync oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.phase != widget.phase ||
        oldWidget.questionIndex != widget.questionIndex ||
        oldWidget.questionTotalOverride != widget.questionTotalOverride) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
