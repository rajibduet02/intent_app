import 'package:flutter/material.dart';

import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/core/widgets/app_snackbar_card.dart';

const Duration _kAuthSnackbarEnterDuration = Duration(milliseconds: 250);

/// Auth toasts: custom card via [ScaffoldMessenger].
abstract final class AuthSnackbar {
  AuthSnackbar._();

  static void success({required String title, required String message}) {
    _show(
      variant: AppSnackbarVariant.success,
      title: title,
      message: message,
      displayDuration: const Duration(seconds: 2),
    );
  }

  /// [title] defaults to `'Error'`; use a softer label (e.g. `'Reminder'`) for validation hints.
  static void error(String message, {String title = 'Error'}) {
    _show(
      variant: AppSnackbarVariant.error,
      title: title,
      message: message,
      displayDuration: const Duration(seconds: 3),
    );
  }

  static void _show({
    required AppSnackbarVariant variant,
    required String title,
    required String message,
    required Duration displayDuration,
  }) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      return;
    }
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        duration: displayDuration,
        content: _SnackbarEntrance(
          child: AppSnackbarCard(
            variant: variant,
            title: title,
            message: message,
          ),
        ),
      ),
    );
  }
}

/// Fade + slight upward motion while the snackbar animates in.
class _SnackbarEntrance extends StatefulWidget {
  const _SnackbarEntrance({required this.child});

  final Widget child;

  @override
  State<_SnackbarEntrance> createState() => _SnackbarEntranceState();
}

class _SnackbarEntranceState extends State<_SnackbarEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _kAuthSnackbarEnterDuration,
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.08),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
