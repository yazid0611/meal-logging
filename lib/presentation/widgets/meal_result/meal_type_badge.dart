import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class MealTypeBadge extends StatelessWidget {
  final String mealType;

  const MealTypeBadge({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        mealType,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'DM Sans',
        ),
      ),
    );
  }
}
