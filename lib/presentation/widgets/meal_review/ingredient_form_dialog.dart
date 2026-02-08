import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/ingredient_constants.dart';
import 'package:meal_logging/domain/entities/ingredient_entity.dart';
import 'package:meal_logging/presentation/widgets/dialogs/base_dialog.dart';
import 'package:meal_logging/presentation/widgets/meal_review/custom_drop_down.dart';
import 'package:meal_logging/presentation/widgets/shared/dialog_action_buttons.dart';
import 'package:meal_logging/presentation/widgets/shared/dialog_text_field.dart';
import 'package:meal_logging/presentation/widgets/meal_review/form_label.dart';

class IngredientFormDialog extends StatefulWidget {
  final IngredientEntity? ingredient;
  final Function(IngredientEntity) onSave;

  const IngredientFormDialog({
    super.key,
    this.ingredient,
    required this.onSave,
  });

  bool get isEditing => ingredient != null;

  @override
  State<IngredientFormDialog> createState() => IngredientFormDialogState();
}

class IngredientFormDialogState extends State<IngredientFormDialog> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.ingredient?.name ?? '');
    quantityController = TextEditingController(
      text: widget.ingredient?.quantity.toString() ?? '1',
    );

    selectedUnit = widget.ingredient?.unit ?? 'grams (g)';
    if (!IngredientConstants.units.contains(selectedUnit)) {
      selectedUnit = IngredientConstants.units.first;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void handleSave() {
    if (nameController.text.isNotEmpty) {
      widget.onSave(
        IngredientEntity(
          name: nameController.text,
          quantity: int.tryParse(quantityController.text) ?? 1,
          unit: selectedUnit,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.isEditing ? 'Edit Ingredient' : 'Add New Ingredient',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel('Ingredient Name'),
          const SizedBox(height: 8),
          DialogTextField(
            controller: nameController,
            hintText: 'e.g., Chicken Breast',
          ),
          const SizedBox(height: 16),
          const FormLabel('Quantity'),
          const SizedBox(height: 8),
          DialogTextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            hintText: '1',
          ),
          const SizedBox(height: 16),
          const FormLabel('Unit'),
          const SizedBox(height: 8),
          CustomDropdown(
            value: selectedUnit,
            items: IngredientConstants.units,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedUnit = value;
                });
              }
            },
          ),
          const SizedBox(height: 24),
          DialogActionButtons(
            onCancel: () => Navigator.pop(context),
            onSave: handleSave,
          ),
        ],
      ),
    );
  }
}
