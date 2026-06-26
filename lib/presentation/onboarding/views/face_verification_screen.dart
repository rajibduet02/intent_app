import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/face_verification_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/face_verification_state.dart';
import 'package:intent_app/presentation/onboarding/services/face_scan_session.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class FaceVerificationScreen extends ConsumerStatefulWidget {
  const FaceVerificationScreen({super.key});

  @override
  ConsumerState<FaceVerificationScreen> createState() =>
      _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends ConsumerState<FaceVerificationScreen>
    with WidgetsBindingObserver {
  FaceScanSession? _scanSession;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scanSession = _createScanSession();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_scanSession?.dispose());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      unawaited(_scanSession?.stop());
      ref.read(faceVerificationProvider.notifier).resetScan();
    }
  }

  FaceScanSession _createScanSession() {
    return FaceScanSession(
      onPhaseChanged: ({
        required bool isStarting,
        required bool isScanning,
        required bool isVerifying,
        required String statusLabel,
      }) {
        if (!mounted) {
          return;
        }
        final notifier = ref.read(faceVerificationProvider.notifier);
        final phase = isStarting
            ? FaceScanPhase.starting
            : isVerifying
                ? FaceScanPhase.verifying
                : isScanning
                    ? FaceScanPhase.scanning
                    : FaceScanPhase.idle;
        notifier.setPhase(phase, statusLabel: statusLabel);
      },
      onProgress: (progress) {
        if (!mounted) {
          return;
        }
        ref.read(faceVerificationProvider.notifier).setProgress(progress);
      },
      onCompleted: (path) {
        if (!mounted) {
          return;
        }
        ref.read(faceVerificationProvider.notifier).completeScan(
              selfiePath: path,
            );
        _showSuccess('Face Verification Successful');
      },
      onError: (message) {
        if (!mounted) {
          return;
        }
        _showError(message);
        ref.read(faceVerificationProvider.notifier).resetScan();
      },
    );
  }

  Future<void> _startScan() async {
    final state = ref.read(faceVerificationProvider);
    if (!state.canStartScan && state.phase != FaceScanPhase.completed) {
      return;
    }

    if (state.phase == FaceScanPhase.completed) {
      await _scanSession?.dispose();
      ref.read(faceVerificationProvider.notifier).resetScan();
      _scanSession = _createScanSession();
    }

    await _scanSession?.start();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleBack() async {
    await _scanSession?.stop();
    if (!mounted) {
      return;
    }
    ref.read(faceVerificationProvider.notifier).onBack();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.intentForest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(faceVerificationProvider.notifier);
    final state = ref.watch(faceVerificationProvider);
    final scanSession = _scanSession;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TakeSelfieButton(
              isLoading: state.phase == FaceScanPhase.starting,
              isScanActive: state.isScanActive,
              isCompleted: state.phase == FaceScanPhase.completed,
              onPressed: state.canStartScan ? () => unawaited(_startScan()) : null,
            ),
            if (state.canContinue) ...[
              const SizedBox(height: 10),
              OnboardingContinueButton(
                isLoading: state.isLoading,
                onPressed: () => unawaited(notifier.submit()),
              ),
            ],
            const SizedBox(height: 14),
            const _EncryptedFooterNote(),
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _pinnedFooterHeight(state.canContinue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FaceVerificationHeader(onBack: () => unawaited(_handleBack())),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Confirm it\'s you',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Follow the guide to take a quick selfie.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: AppSpacing.lg),
            _FaceScanPreview(
              controller: scanSession?.controller,
              selfiePath: state.selfiePath,
              scanProgress: state.scanProgress,
              phase: state.phase,
              statusLabel: state.statusLabel,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _VerificationTipsRow(),
          ],
        ),
      ),
    );
  }
}

double _pinnedFooterHeight(bool showContinue) =>
    showContinue ? 168 : 108;

class _FaceVerificationHeader extends StatelessWidget {
  const _FaceVerificationHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
        ],
      ),
    );
  }
}

class _FaceScanPreview extends StatelessWidget {
  const _FaceScanPreview({
    required this.controller,
    required this.selfiePath,
    required this.scanProgress,
    required this.phase,
    required this.statusLabel,
  });

  final CameraController? controller;
  final String? selfiePath;
  final double scanProgress;
  final FaceScanPhase phase;
  final String statusLabel;

  static const double _height = 340;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.intentForestDark,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppShadows.intentInput,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: _height,
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final frameSize = Size(constraints.maxWidth, _height);
              final ovalRect = faceScanOvalRect(frameSize);

              return Stack(
                fit: StackFit.expand,
                children: [
                  _PreviewBackground(
                    controller: controller,
                    selfiePath: selfiePath,
                    phase: phase,
                  ),
                  CustomPaint(
                    painter: _OvalMaskPainter(ovalRect: ovalRect),
                  ),
                  if (phase == FaceScanPhase.verifying || scanProgress > 0)
                    CustomPaint(
                      painter: _OvalProgressRingPainter(
                        ovalRect: ovalRect,
                        progress: scanProgress,
                      ),
                    ),
                  CustomPaint(
                    painter: _FaceOvalGuidePainter(
                      ovalRect: ovalRect,
                      showDashed: phase != FaceScanPhase.verifying,
                    ),
                  ),
                  const Positioned.fill(child: _CornerBrackets()),
                  if (phase != FaceScanPhase.completed)
                    Align(
                      alignment: Alignment(
                        0,
                        ((ovalRect.center.dy / _height) * 2) - 1 + 0.16,
                      ),
                      child: _StatusBadge(label: statusLabel),
                    ),
                  if (phase == FaceScanPhase.completed) ...[
                    Positioned.fill(
                      child: ColoredBox(
                        color: AppColors.intentForest.withValues(alpha: 0.45),
                      ),
                    ),
                    Positioned(
                      left: ovalRect.center.dx - (_SuccessCheckmark.size / 2),
                      top: ovalRect.center.dy - (_SuccessCheckmark.size / 2),
                      child: const _SuccessCheckmark(),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PreviewBackground extends StatelessWidget {
  const _PreviewBackground({
    required this.controller,
    required this.selfiePath,
    required this.phase,
  });

  final CameraController? controller;
  final String? selfiePath;
  final FaceScanPhase phase;

  @override
  Widget build(BuildContext context) {
    if (phase == FaceScanPhase.completed) {
      final hasImage = selfiePath != null &&
          selfiePath!.isNotEmpty &&
          File(selfiePath!).existsSync();

      return Stack(
        fit: StackFit.expand,
        children: [
          if (hasImage)
            Image.file(
              File(selfiePath!),
              fit: BoxFit.cover,
            )
          else
            const _PreviewPlaceholder(),
        ],
      );
    }

    final camera = controller;
    if (camera != null &&
        camera.value.isInitialized &&
        phase != FaceScanPhase.idle) {
      return _CameraPreviewFill(controller: camera);
    }

    return const _PreviewPlaceholder();
  }
}

class _PreviewPlaceholder extends StatelessWidget {
  const _PreviewPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF2A3D37),
            AppColors.intentForestDark,
          ],
        ),
      ),
    );
  }
}

class _SuccessCheckmark extends StatelessWidget {
  const _SuccessCheckmark();

  static const double size = 56;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_rounded,
        color: AppColors.intentForest,
        size: 32,
      ),
    );
  }
}

class _CameraPreviewFill extends StatelessWidget {
  const _CameraPreviewFill({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: controller.value.previewSize?.height ?? 1,
        height: controller.value.previewSize?.width ?? 1,
        child: CameraPreview(controller),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2F2E).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
          fontSize: 8,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
    );
  }
}

Rect faceScanOvalRect(Size frameSize) {
  return Rect.fromCenter(
    center: Offset(frameSize.width * 0.5, frameSize.height * 0.5),
    width: frameSize.width * 0.56,
    // height: frameSize.height * 0.8,
    height: frameSize.height * 0.74,
  );
}

class _OvalMaskPainter extends CustomPainter {
  const _OvalMaskPainter({required this.ovalRect});

  final Rect ovalRect;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
      path,
      Paint()..color = Colors.black.withValues(alpha: 0.58),
    );
  }

  @override
  bool shouldRepaint(covariant _OvalMaskPainter oldDelegate) {
    return oldDelegate.ovalRect != ovalRect;
  }
}

class _OvalProgressRingPainter extends CustomPainter {
  const _OvalProgressRingPainter({
    required this.ovalRect,
    required this.progress,
  });

  final Rect ovalRect;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final ringRect = ovalRect.inflate(8);
    final trackPaint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final progressPaint = Paint()
      ..color = AppColors.intentGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawOval(ringRect, trackPaint);
    if (progress <= 0) {
      return;
    }

    canvas.drawArc(
      ringRect,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _OvalProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.ovalRect != ovalRect;
  }
}

class _FaceOvalGuidePainter extends CustomPainter {
  const _FaceOvalGuidePainter({
    required this.ovalRect,
    required this.showDashed,
  });

  final Rect ovalRect;
  final bool showDashed;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentGold.withValues(alpha: showDashed ? 1 : 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    if (!showDashed) {
      canvas.drawOval(ovalRect, paint);
      return;
    }

    const dashWidth = 6.0;
    const dashSpace = 5.0;
    final path = Path()..addOval(ovalRect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FaceOvalGuidePainter oldDelegate) {
    return oldDelegate.ovalRect != ovalRect ||
        oldDelegate.showDashed != showDashed;
  }
}

class _CornerBrackets extends StatelessWidget {
  const _CornerBrackets();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CornerBracketPainter());
  }
}

class _CornerBracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentGold
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const arm = 22.0;
    const inset = 14.0;

    void drawBracket(Offset origin, {required bool top, required bool left}) {
      final path = Path();
      if (top && left) {
        path.moveTo(origin.dx, origin.dy + arm);
        path.lineTo(origin.dx, origin.dy);
        path.lineTo(origin.dx + arm, origin.dy);
      } else if (top && !left) {
        path.moveTo(origin.dx - arm, origin.dy);
        path.lineTo(origin.dx, origin.dy);
        path.lineTo(origin.dx, origin.dy + arm);
      } else if (!top && left) {
        path.moveTo(origin.dx, origin.dy - arm);
        path.lineTo(origin.dx, origin.dy);
        path.lineTo(origin.dx + arm, origin.dy);
      } else {
        path.moveTo(origin.dx - arm, origin.dy);
        path.lineTo(origin.dx, origin.dy);
        path.lineTo(origin.dx, origin.dy - arm);
      }
      canvas.drawPath(path, paint);
    }

    drawBracket(Offset(inset, inset), top: true, left: true);
    drawBracket(Offset(size.width - inset, inset), top: true, left: false);
    drawBracket(Offset(inset, size.height - inset), top: false, left: true);
    drawBracket(
      Offset(size.width - inset, size.height - inset),
      top: false,
      left: false,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _VerificationTipsRow extends StatelessWidget {
  const _VerificationTipsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _VerificationTip(
            icon: Icons.wb_sunny_outlined,
            label: 'Good light',
          ),
        ),
        Expanded(
          child: _VerificationTip(
            icon: Icons.sentiment_satisfied_alt_outlined,
            label: 'Clear view',
          ),
        ),
        Expanded(
          child: _VerificationTip(
            icon: Icons.smartphone_outlined,
            label: 'Hold still',
          ),
        ),
      ],
    );
  }
}

class _VerificationTip extends StatelessWidget {
  const _VerificationTip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.intentSegmentFill,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 12,
            color: AppColors.intentText,
          ),
        ),
      ],
    );
  }
}

class _TakeSelfieButton extends StatelessWidget {
  const _TakeSelfieButton({
    required this.isLoading,
    required this.isScanActive,
    required this.isCompleted,
    required this.onPressed,
  });

  final bool isLoading;
  final bool isScanActive;
  final bool isCompleted;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final label = isCompleted
        ? 'SCAN AGAIN'
        : isScanActive
            ? 'SCANNING...'
            : 'TAKE SELFIE';

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: (isLoading || (isScanActive && !isCompleted))
            ? null
            : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.intentForest,
          disabledBackgroundColor: AppColors.intentForest.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: IntentLoginStyles.onboardingContinue.copyWith(
                      letterSpacing: 1.4,
                    ),
                  ),
                  if (!isScanActive) ...[
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(
                      Icons.photo_camera_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

class _EncryptedFooterNote extends StatelessWidget {
  const _EncryptedFooterNote();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 14,
            color: AppColors.intentTextSoft.withValues(alpha: 0.9),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'Your data is encrypted and secure',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
