import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class MealTypeBadge extends StatelessWidget {
  final String mealType;

  const MealTypeBadge({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        mealType,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
