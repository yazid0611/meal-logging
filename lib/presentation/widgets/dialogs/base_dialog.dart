import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onClose;
  final bool showCloseButton;
  final Color? backgroundColor;

  const BaseDialog({
    super.key,
    required this.title,
    required this.child,
    this.onClose,
    this.showCloseButton = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor ?? AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DM Sans',
                    color: AppColors.textPrimary,
                  ),
                ),
                if (showCloseButton)
                  IconButton(
                    onPressed: onClose ?? () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: AppColors.textSecondary,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            child,
          ],
        ),
      ),
    );
  }
}
