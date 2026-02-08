import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/domain/entities/ingredient_entity.dart';
import 'package:meal_logging/presentation/widgets/meal_review/circle_icon_button.dart';

class IngredientCard extends StatelessWidget {
  final IngredientEntity ingredient;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DM Sans',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${ingredient.quantity} ${ingredient.unit}',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'DM Sans',
                    color: AppColors.textSecondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CircleIconButton(
                backgroundColor: const Color(0xFFE3F2FD),
                icon: Icons.edit_outlined,
                iconColor: AppColors.primary,
                onTap: onEdit,
              ),
              const SizedBox(width: 8),
              CircleIconButton(
                backgroundColor: const Color(0xFFFFEBEE),
                icon: Icons.delete_outline,
                iconColor: AppColors.error,
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
