import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

Future<Set<String>?> showOnboardingMultiSelectSheet({
  required BuildContext context,
  required String title,
  required List<String> options,
  required Set<String> initialSelected,
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      var selected = Set<String>.from(initialSelected);
      final maxHeight = MediaQuery.sizeOf(context).height * 0.55;

      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: IntentLoginStyles.fieldLabel.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final item = options[index];
                        final isSelected = selected.contains(item);
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item,
                            style: IntentLoginStyles.fieldHint.copyWith(
                              color: AppColors.intentText,
                            ),
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: isSelected
                                ? AppColors.intentForest
                                : AppColors.intentTextSoft,
                            size: 22,
                          ),
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selected.remove(item);
                              } else {
                                selected.add(item);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.primaryButtonHeight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, selected),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.intentForest,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.primaryButtonBorderRadius,
                          ),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: IntentLoginStyles.onboardingContinue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
