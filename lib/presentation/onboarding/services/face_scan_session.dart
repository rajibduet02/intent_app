import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

typedef FaceScanPhaseCallback = void Function({
  required bool isStarting,
  required bool isScanning,
  required bool isVerifying,
  required String statusLabel,
});

typedef FaceScanProgressCallback = void Function(double progress);
typedef FaceScanCompleteCallback = void Function(String? imagePath);
typedef FaceScanErrorCallback = void Function(String message);

/// Demo face-scan session: live camera preview + simulated verification progress.
class FaceScanSession {
  FaceScanSession({
    required this.onPhaseChanged,
    required this.onProgress,
    required this.onCompleted,
    required this.onError,
  });

  final FaceScanPhaseCallback onPhaseChanged;
  final FaceScanProgressCallback onProgress;
  final FaceScanCompleteCallback onCompleted;
  final FaceScanErrorCallback onError;

  CameraController? _controller;
  Timer? _progressTimer;
  bool _isRunning = false;
  double _progress = 0;

  static const Duration _alignDelay = Duration(milliseconds: 900);
  static const Duration _progressTick = Duration(milliseconds: 45);
  static const double _progressStep = 0.022;

  CameraController? get controller => _controller;

  bool get isRunning => _isRunning;

  Future<void> start() async {
    if (_isRunning) {
      return;
    }

    _isRunning = true;
    _progress = 0;
    onProgress(0);

    onPhaseChanged(
      isStarting: true,
      isScanning: false,
      isVerifying: false,
      statusLabel: 'STARTING CAMERA',
    );

    await _tryStartCameraPreview();

    if (!_isRunning) {
      return;
    }

    onPhaseChanged(
      isStarting: false,
      isScanning: true,
      isVerifying: false,
      statusLabel: 'ALIGN FACE',
    );

    await Future<void>.delayed(_alignDelay);
    if (!_isRunning) {
      return;
    }

    onPhaseChanged(
      isStarting: false,
      isScanning: false,
      isVerifying: true,
      statusLabel: 'HOLD STILL',
    );

    _startSimulatedProgress();
  }

  Future<void> _tryStartCameraPreview() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted && !status.isLimited) {
        return;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );

      await controller.initialize();
      _controller = controller;
    } catch (_) {
      // Demo scan continues with the placeholder preview if camera fails.
    }
  }

  void _startSimulatedProgress() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(_progressTick, (timer) {
      if (!_isRunning) {
        timer.cancel();
        return;
      }

      _progress = (_progress + _progressStep).clamp(0, 1);
      onProgress(_progress);

      if (_progress >= 1) {
        timer.cancel();
        unawaited(_completeDemo());
      }
    });
  }

  Future<void> _completeDemo() async {
    if (!_isRunning) {
      return;
    }

    _isRunning = false;
    String? imagePath;

    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      try {
        final file = await controller.takePicture();
        imagePath = file.path;
      } catch (_) {
        imagePath = null;
      }
    }

    onPhaseChanged(
      isStarting: false,
      isScanning: false,
      isVerifying: false,
      statusLabel: 'Face Verification Successful',
    );
    onProgress(1);
    onCompleted(imagePath);
  }

  Future<void> stop() async {
    _isRunning = false;
    _progressTimer?.cancel();
    _progressTimer = null;
    _progress = 0;

    final controller = _controller;
    _controller = null;
    if (controller != null) {
      await controller.dispose();
    }
  }

  Future<void> dispose() async {
    await stop();
  }
}
