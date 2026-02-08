import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class MealImagePlaceholder extends StatelessWidget {
  final double height;

  const MealImagePlaceholder({super.key, this.height = 180});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 56,
            color: AppColors.textTertiary.withOpacity(0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'Meal captured through input',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textTertiary.withOpacity(0.7),
              fontFamily: 'DM Sans',
            ),
          ),
        ],
      ),
    );
  }
}
