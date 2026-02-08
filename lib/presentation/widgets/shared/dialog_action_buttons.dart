import 'package:flutter/material.dart';
import 'package:meal_logging/presentation/widgets/shared/app_button.dart';

class DialogActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String saveText;
  final String cancelText;
  final bool isDestructive;

  const DialogActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.saveText = 'Save',
    this.cancelText = 'Cancel',
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DialogButton(
          text: cancelText,
          onPressed: onCancel,
        ),
        const SizedBox(width: 12),
        if (isDestructive)
          DestructiveButton(text: saveText, onPressed: onSave)
        else
          DialogButton(text: saveText, onPressed: onSave, isPrimary: true),
      ],
    );
  }
}