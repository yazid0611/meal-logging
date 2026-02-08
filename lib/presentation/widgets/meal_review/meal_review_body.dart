import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meal_logging/core/utils/picker_utils.dart';
import 'package:meal_logging/domain/entities/ingredient_entity.dart';
import 'package:meal_logging/presentation/bloc/ingredients/ingredients_bloc.dart';
import 'package:meal_logging/presentation/widgets/dialogs/delete_confirmation_dialog.dart';
import 'package:meal_logging/presentation/widgets/dialogs/edit_dishname_dialog.dart';
import 'package:meal_logging/presentation/widgets/meal_review/info_card.dart';
import 'package:meal_logging/presentation/widgets/meal_review/ingredient_card.dart';
import 'package:meal_logging/presentation/widgets/meal_review/ingredient_form_dialog.dart';
import '../../../core/constants/app_colors.dart';

class MealReviewBody extends StatefulWidget {
  final IngredientsState state;

  const MealReviewBody({super.key, required this.state});

  @override
  State<MealReviewBody> createState() => _MealReviewBodyState();
}

class _MealReviewBodyState extends State<MealReviewBody> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    final dish = widget.state.dish;
    if (dish == null) return const SizedBox();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Tap to edit any detail',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'DM Sans',
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSectionLabel('Meal Name'),
                const SizedBox(height: 12),
                InfoCard(
                  child: buildEditableField(
                    text: dish.dishName,
                    textColor: AppColors.primary,
                    icon: Icons.edit_outlined,
                    onTap: () => editDishName(context, dish.dishName),
                  ),
                ),
                const SizedBox(height: 24),

                buildSectionLabel('Date'),
                const SizedBox(height: 12),
                InfoCard(
                  child: buildEditableField(
                    text: DateFormat('dd/MM/yyyy').format(selectedDate),
                    textColor: AppColors.primary,
                    icon: Icons.calendar_today_outlined,
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(height: 24),

                buildSectionLabel('Time'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedTime.format(context),
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'DM Sans',
                                color: AppColors.primary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => selectTime(context),
                              child: Icon(
                                Icons.access_time,
                                size: 20,
                                color: AppColors.textSecondary.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: setCurrentTime,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Now',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'DM Sans',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                buildSectionLabel('Ingredients'),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dish.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = dish.ingredients[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: IngredientCard(
                        ingredient: ingredient,
                        onEdit: () =>
                            editIngredient(context, ingredient, index),
                        onDelete: () =>
                            deleteIngredient(context, ingredient.name, index),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 8),

                // Add More Button
                Center(
                  child: TextButton.icon(
                    onPressed: () => addIngredient(context),
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    label: const Text(
                      'Add More',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'DM Sans',
                        color: AppColors.primary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'DM Sans',
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget buildEditableField({
    required String text,
    required Color textColor,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'DM Sans',
                color: textColor,
              ),
            ),
          ),
          Icon(icon, size: 20, color: AppColors.textSecondary.withOpacity(0.5)),
        ],
      ),
    );
  }

  void editDishName(BuildContext context, String currentName) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<IngredientsBloc>(),
        child: EditDishNameDialog(initialName: currentName),
      ),
    );
  }

  void addIngredient(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => IngredientFormDialog(
        onSave: (ingredient) {
          context.read<IngredientsBloc>().add(AddIngredientEvent(ingredient));
        },
      ),
    );
  }

  void editIngredient(
    BuildContext context,
    IngredientEntity ingredient,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => IngredientFormDialog(
        ingredient: ingredient,
        onSave: (updatedIngredient) {
          context.read<IngredientsBloc>().add(
            UpdateIngredientEvent(index: index, ingredient: updatedIngredient),
          );
        },
      ),
    );
  }

  void deleteIngredient(BuildContext context, String itemName, int index) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeleteConfirmationDialog(
        itemName: itemName,
        onDelete: () {
          context.read<IngredientsBloc>().add(RemoveIngredientEvent(index));
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await PickerUtils.selectDate(
      context,
      initialDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final picked = await PickerUtils.selectTime(
      context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  void setCurrentTime() {
    setState(() => selectedTime = TimeOfDay.now());
  }
}
