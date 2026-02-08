import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_logging/presentation/bloc/ingredients/ingredients_bloc.dart';
import 'package:meal_logging/presentation/widgets/dialogs/base_dialog.dart';
import 'package:meal_logging/presentation/widgets/shared/dialog_action_buttons.dart';
import 'package:meal_logging/presentation/widgets/shared/dialog_text_field.dart';
import 'package:meal_logging/presentation/widgets/meal_review/form_label.dart';

class EditDishNameDialog extends StatefulWidget {
  final String initialName;

  const EditDishNameDialog({super.key, required this.initialName});

  @override
  State<EditDishNameDialog> createState() => _EditDishNameDialogState();
}

class _EditDishNameDialogState extends State<EditDishNameDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_controller.text.trim().isNotEmpty) {
      context.read<IngredientsBloc>().add(
        UpdateDishNameEvent(_controller.text.trim()),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Edit Meal Name',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel('Meal Name'),
          const SizedBox(height: 8),
          DialogTextField(
            controller: _controller,
            hintText: 'Enter meal name',
            autofocus: true,
          ),
          const SizedBox(height: 24),
          DialogActionButtons(
            onCancel: () => Navigator.pop(context),
            onSave: _handleSave,
          ),
        ],
      ),
    );
  }
}
