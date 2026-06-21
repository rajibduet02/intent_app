import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/auth_form_input.dart';

/// Rounded login input matching Figma (no label, icon + hint + optional suffix).
class LoginInputField extends StatelessWidget {
  const LoginInputField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return AuthFormInput(
      controller: controller,
      focusNode: focusNode,
      hintText: hintText,
      prefixIcon: prefixIcon,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      validator: validator,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      fillColor: AppColors.intentInputFill,
      borderRadius: 14,
    );
  }
}
