import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/presentation/widgets/meal_result/meal_type_badge.dart';

class MealHeader extends StatelessWidget {
  final String dishName;
  final String mealType;
  final DateTime? timestamp;

  MealHeader({
    super.key,
    required this.dishName,
    this.mealType = 'Breakfast',
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dishName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: 'DM Sans',
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      DateFormat(
                        "MMMM d, yyyy 'at' hh:mm a",
                      ).format(timestamp!),
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                  ),
                  SizedBox(width: 60),
                  MealTypeBadge(mealType: mealType),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
