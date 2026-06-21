import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intent_app/app/theme/theme.dart';

class VerifyOtpInput extends StatefulWidget {
  const VerifyOtpInput({
    super.key,
    required this.onChanged,
    this.onCompleted,
    this.length = 6,
  });

  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final int length;

  @override
  State<VerifyOtpInput> createState() => _VerifyOtpInputState();
}

class _VerifyOtpInputState extends State<VerifyOtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    for (var i = 0; i < widget.length; i++) {
      _focusNodes[i].addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _notifyChange() {
    // Read controllers after the frame so the active cell's text is committed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final code = _controllers.map((c) => c.text).join();
      widget.onChanged(code);
      if (code.length == widget.length) {
        widget.onCompleted?.call(code);
      }
    });
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      _pasteCode(value);
      return;
    }
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _notifyChange();
  }

  void _pasteCode(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    for (var i = 0; i < widget.length; i++) {
      _controllers[i].text = i < digits.length ? digits[i] : '';
    }
    if (digits.length >= widget.length) {
      _focusNodes.last.unfocus();
    } else if (digits.isNotEmpty) {
      _focusNodes[digits.length.clamp(0, widget.length - 1)].requestFocus();
    }
    _notifyChange();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < widget.length; i++)
          _OtpCell(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            isActive: _focusNodes[i].hasFocus,
            onChanged: (v) => _onChanged(i, v),
          ),
      ],
    );
  }
}

class _OtpCell extends StatelessWidget {
  const _OtpCell({
    required this.controller,
    required this.focusNode,
    required this.isActive,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isActive;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final hasValue = controller.text.isNotEmpty;

    return SizedBox(
      width: 48,
      height: AppSpacing.inputFieldHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.intentInput,
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: IntentLoginStyles.verifyDestination.copyWith(fontSize: 20),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isActive
                    ? AppColors.intentForest
                    : AppColors.intentGoldMuted.withValues(alpha: 0.55),
                width: isActive ? 1.5 : 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isActive
                    ? AppColors.intentForest
                    : AppColors.intentGoldMuted.withValues(alpha: 0.55),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.intentForest,
                width: 1.5,
              ),
            ),
            hintText: hasValue ? null : '–',
            hintStyle: IntentLoginStyles.fieldHint.copyWith(
              fontSize: 18,
              color: AppColors.intentTextSoft.withValues(alpha: 0.45),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
