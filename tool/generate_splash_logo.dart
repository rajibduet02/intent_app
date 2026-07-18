import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:intent_app/core/constants/splash_branding.dart';

/// Must match [AppAssets.mainLogo] / Flutter [IntentLogo] on [SplashScreen].
const String _sourceLogoPath = 'assets/icons/main_logo.png';

/// High-res master written for native splash generation (same artwork, sharper).
const String _highResLogoPath = 'assets/icons/main_logo_hd.png';

/// Longest edge for the splash master source (4× typical xxxhdpi artwork).
const int _highResLongestSide = 1024;

/// Android 12+ animated icon canvas (flutter_native_splash recommendation).
const int _android12CanvasSize = 1152;

/// Master asset density for native splash bitmaps (4x = xxxhdpi baseline).
const int _nativePixelDensity = 4;

/// Supersampling factor when resizing the logo for sharper downscales.
const int _superSampleFactor = 6;

/// Transparent inset on the standard splash canvas so edges are never clipped.
const double _standardInsetRatio = 0.04;

/// Android 12 masks the icon to a circle; keep artwork inside the 2/3 safe zone.
const double _android12SafeZoneRatio = 2 / 3;

Future<void> main() async {
  final nativeLogicalSize = SplashBranding.nativeLogoSize.round();
  final nativePixelSize = nativeLogicalSize * _nativePixelDensity;

  final source = await _loadHighResSourceImage();
  if (source == null) {
    exitCode = 1;
    return;
  }

  final aspect = source.width / source.height;

  final standardLogoSide = (nativePixelSize * (1 - 2 * _standardInsetRatio))
      .round();
  final standardLogo = _resizeLogoHighQuality(source, standardLogoSide, aspect);

  final standardCanvas = img.Image(
    width: nativePixelSize,
    height: nativePixelSize,
    numChannels: 4,
  );
  img.fill(standardCanvas, color: img.ColorRgba8(0, 0, 0, 0));
  _compositeCentered(standardCanvas, standardLogo);

  final standardOutput = File('assets/icons/splash_logo.png');
  await standardOutput.writeAsBytes(img.encodePng(standardCanvas));
  stdout.writeln(
    'Wrote ${standardOutput.path} (${standardCanvas.width}x'
    '${standardCanvas.height}) at ${nativeLogicalSize}dp.',
  );

  final android12SafeDiameter =
      _android12CanvasSize * _android12SafeZoneRatio * 0.96;
  final android12LogoSide = math.min(
    standardLogoSide,
    _maxWidthInCircle(android12SafeDiameter, aspect),
  );
  final android12Logo = android12LogoSide == standardLogoSide
      ? standardLogo
      : _resizeLogoHighQuality(source, android12LogoSide, aspect);

  final android12Canvas = img.Image(
    width: _android12CanvasSize,
    height: _android12CanvasSize,
    numChannels: 4,
  );
  img.fill(android12Canvas, color: img.ColorRgba8(0, 0, 0, 0));
  _compositeCentered(android12Canvas, android12Logo);

  final android12Output = File('assets/icons/splash_logo_android12.png');
  await android12Output.writeAsBytes(img.encodePng(android12Canvas));
  stdout.writeln(
    'Wrote ${android12Output.path} (${android12Canvas.width}x'
    '${android12Canvas.height}) with ${android12LogoSide}px logo '
    '(${(android12LogoSide / _nativePixelDensity).toStringAsFixed(1)}dp).',
  );
}

Future<img.Image?> _loadHighResSourceImage() async {
  final sourceFile = File(_sourceLogoPath);
  if (!sourceFile.existsSync()) {
    stderr.writeln('Missing $_sourceLogoPath');
    return null;
  }

  final original = img.decodeImage(sourceFile.readAsBytesSync());
  if (original == null) {
    stderr.writeln('Could not decode $_sourceLogoPath');
    return null;
  }

  final longest = math.max(original.width, original.height);
  if (longest >= _highResLongestSide) {
    stdout.writeln(
      'Using $_sourceLogoPath (${original.width}x${original.height}) as source.',
    );
    return original;
  }

  final highRes = _upscaleProgressively(original, _highResLongestSide);
  final hdFile = File(_highResLogoPath);
  await hdFile.writeAsBytes(img.encodePng(highRes));
  stdout.writeln(
    'Wrote $_highResLogoPath (${highRes.width}x${highRes.height}) '
    'from $_sourceLogoPath (${original.width}x$longest).',
  );
  return highRes;
}

/// Gradual 2× upscales produce cleaner results than a single large jump.
img.Image _upscaleProgressively(img.Image source, int targetLongestSide) {
  var working = source;
  var longest = math.max(working.width, working.height);

  while (longest < targetLongestSide) {
    final nextLongest = math.min(longest * 2, targetLongestSide);
    final scale = nextLongest / longest;
    final nextW = (working.width * scale).round();
    final nextH = (working.height * scale).round();
    working = img.copyResize(
      working,
      width: nextW,
      height: nextH,
      interpolation: img.Interpolation.cubic,
      backgroundColor: img.ColorRgba8(0, 0, 0, 0),
    );
    longest = math.max(working.width, working.height);
  }

  return working;
}

/// Max width for a [width]/[height] logo fully inside a circle of [diameter].
int _maxWidthInCircle(double diameter, double widthOverHeight) {
  final radius = diameter / 2;
  final maxWidth =
      2 * radius / math.sqrt(1 + 1 / (widthOverHeight * widthOverHeight));
  return maxWidth.floor();
}

/// Resize with supersampling; [maxSide] is the longest edge, aspect preserved.
img.Image _resizeLogoHighQuality(
  img.Image source,
  int maxSide,
  double widthOverHeight,
) {
  final targetW = widthOverHeight >= 1
      ? maxSide
      : (maxSide * widthOverHeight).round();
  final targetH = widthOverHeight >= 1
      ? (maxSide / widthOverHeight).round()
      : maxSide;

  final superSample = _superSampleFactor;
  final superW = targetW * superSample;
  final superH = targetH * superSample;

  final upscaled = img.copyResize(
    source,
    width: superW,
    height: superH,
    interpolation: img.Interpolation.cubic,
    backgroundColor: img.ColorRgba8(0, 0, 0, 0),
  );

  return img.copyResize(
    upscaled,
    width: targetW,
    height: targetH,
    interpolation: img.Interpolation.cubic,
    backgroundColor: img.ColorRgba8(0, 0, 0, 0),
  );
}

void _compositeCentered(img.Image canvas, img.Image logo) {
  img.compositeImage(
    canvas,
    logo,
    dstX: (canvas.width - logo.width) ~/ 2,
    dstY: (canvas.height - logo.height) ~/ 2,
  );
}
