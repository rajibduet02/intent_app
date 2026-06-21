import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/auth_form_input.dart';

/// Signup field with label above and white rounded input.
class SignupLabeledField extends StatelessWidget {
  const SignupLabeledField({
    super.key,
    required this.label,
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

  final String label;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: IntentLoginStyles.fieldLabel),
        const SizedBox(height: 8),
        AuthFormInput(
          controller: controller,
          focusNode: focusNode,
          hintText: hintText,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          validator: validator,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
        ),
      ],
    );
  }
}
