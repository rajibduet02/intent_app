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
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.hideMaxLengthCounter = false,
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
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool hideMaxLengthCounter;

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
        final isMultiline = maxLines > 1 || minLines > 1;
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
          minLines: isMultiline ? minLines : 1,
          maxLines: isMultiline ? maxLines : 1,
          maxLength: maxLength,
          buildCounter: hideMaxLengthCounter
              ? (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) =>
                  null
              : null,
          textAlignVertical:
              isMultiline ? TextAlignVertical.top : TextAlignVertical.center,
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
            contentPadding: isMultiline
                ? const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    right: AppSpacing.md,
                  )
                : AppSpacing.inputFieldPrefixContentPadding,
            prefixIconConstraints: AppSpacing.inputFieldIconConstraints,
            suffixIconConstraints: const BoxConstraints(
              minWidth: AppSpacing.inputFieldHeight,
              minHeight: AppSpacing.inputFieldHeight,
            ),
            constraints: isMultiline
                ? BoxConstraints(
                    minHeight: minLines * 16 * 1.4 + 24,
                  )
                : AppSpacing.inputFieldBoxConstraints,
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
          child: isMultiline
              ? input
              : SizedBox(
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
