import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/domain/entities/macros_entity.dart';
import 'package:meal_logging/presentation/widgets/meal_result/compact_macro_card.dart';
import 'package:meal_logging/presentation/widgets/meal_result/macro_card.dart';

class NutritionalBreakdownSection extends StatelessWidget {
  final MacrosEntity macros;

  const NutritionalBreakdownSection({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutritional Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'DM Sans',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'This meal adds the following to your daily targets',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontFamily: 'DM Sans',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: MacroNutrientCard(
                  label: 'Calories',
                  value: macros.calories.toStringAsFixed(0),
                  unit: 'g',
                  color: const Color(0xFFFF9500),
                  icon: Icons.local_fire_department_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MacroNutrientCard(
                  label: 'Protein',
                  value: macros.protein.toStringAsFixed(0),
                  unit: 'g',
                  color: const Color(0xFF34C759),
                  icon: Icons.egg_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MacroNutrientCard(
                  label: 'Fat',
                  value: macros.fat.toStringAsFixed(0),
                  unit: 'g',
                  color: const Color(0xFFFFCC00),
                  icon: Icons.water_drop_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: CompactMacroCard(
                  label: 'Carbs',
                  value: macros.carbs.toStringAsFixed(0),
                  unit: 'g',
                  color: const Color(0xFFFF6B6B),
                  icon: Icons.grain_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CompactMacroCard(
                  label: 'Sugar',
                  value: macros.sugar.toStringAsFixed(0),
                  unit: 'g',
                  color: const Color(0xFFBF5AF2),
                  icon: Icons.cookie_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
