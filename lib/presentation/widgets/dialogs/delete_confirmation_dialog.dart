import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/presentation/widgets/dialogs/base_dialog.dart';
import 'package:meal_logging/presentation/widgets/shared/dialog_action_buttons.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onDelete;

  const DeleteConfirmationDialog({
    super.key,
    required this.itemName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Delete Ingredient?',
      backgroundColor: AppColors.surface,
      showCloseButton: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Delete icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 28,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            'Are you sure you want to delete "$itemName"? This action cannot be undone.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontFamily: 'DM Sans',
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Action Buttons
          DialogActionButtons(
            onCancel: () => Navigator.pop(context),
            onSave: () {
              onDelete();
              Navigator.pop(context);
            },
            saveText: 'Delete',
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}
