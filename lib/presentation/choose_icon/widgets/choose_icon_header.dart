import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ChooseIconHeader extends StatelessWidget {
  const ChooseIconHeader({
    super.key,
    required this.onClose,
    this.onMore,
  });

  final VoidCallback onClose;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            alignment: Alignment.centerLeft,
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(
                AppSpacing.backButtonSize,
                AppSpacing.backButtonSize,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.close,
              color: AppColors.intentForest,
              size: 26,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onMore,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              fixedSize: const Size(
                AppSpacing.backButtonSize,
                AppSpacing.backButtonSize,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.more_horiz,
              size: 24,
              color: AppColors.intentForest,
            ),
          ),
        ],
      ),
    );
  }
}
