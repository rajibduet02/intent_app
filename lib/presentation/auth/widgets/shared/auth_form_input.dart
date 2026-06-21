import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/validators.dart';

/// Auth text input that stays a fixed height during [Form] validation.
///
/// Validation errors render below the field only when present, so the input box
/// never shrinks when [FormState.validate] runs.
class AuthFormInput extends StatelessWidget {
  const AuthFormInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.fillColor = AppColors.white,
    this.borderRadius = 12,
    this.showShadow = true,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final Color fillColor;
  final double borderRadius;
  final bool showShadow;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    OutlineInputBorder outlineBorder(
      Color color, {
      double width = 1,
    }) {
      return OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return FormField<String>(
      validator: validator == null
          ? null
          : (_) => validator!(controller.text),
      builder: (field) {
        final hasError = field.hasError;
        final enabledBorderColor =
            hasError ? AppColors.error : AppColors.intentInputBorder;
        final focusedBorderColor =
            hasError ? AppColors.error : AppColors.intentForest;

        final input = TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          style: IntentLoginStyles.fieldHint.copyWith(
            color: AppColors.intentText,
          ),
          onChanged: (value) {
            field.didChange(value);
            if (field.hasError) {
              field.validate();
            }
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: IntentLoginStyles.fieldHint,
            filled: true,
            fillColor: fillColor,
            contentPadding: AppSpacing.inputFieldPrefixContentPadding,
            prefixIconConstraints: AppSpacing.inputFieldIconConstraints,
            suffixIconConstraints: const BoxConstraints(
              minWidth: AppSpacing.inputFieldHeight,
              minHeight: AppSpacing.inputFieldHeight,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.inputFieldLeadingInset,
              ),
              child: Icon(
                prefixIcon,
                color: AppColors.intentForest,
                size: AppSpacing.inputFieldIconSize,
              ),
            ),
            suffixIcon: suffixIcon,
            border: outlineBorder(enabledBorderColor),
            enabledBorder: outlineBorder(enabledBorderColor),
            focusedBorder: outlineBorder(
              focusedBorderColor,
              width: 1.2,
            ),
          ),
        );

        final fieldBox = ClipRRect(
          borderRadius: radius,
          child: SizedBox(
            height: AppSpacing.inputFieldHeight,
            child: input,
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showShadow)
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  boxShadow: AppShadows.intentInput,
                ),
                child: fieldBox,
              )
            else
              fieldBox,
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  field.errorText ?? '',
                  style: Validators.errorMessageStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Trailing field action with a fixed 16px inset from the field edge.
class AuthFormInputSuffixAction extends StatelessWidget {
  const AuthFormInputSuffixAction({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = AppSpacing.inputFieldSuffixIconSize,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.inputFieldHeight,
      height: AppSpacing.inputFieldHeight,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppSpacing.inputFieldTrailingInset,
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: AppColors.intentForest,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
