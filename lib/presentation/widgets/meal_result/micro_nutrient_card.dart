import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/core/utils/micro_formatter.dart';

class MicronutrientCard extends StatelessWidget {
  final String name;
  final double value;

  const MicronutrientCard({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    final displayName = MicronutrientFormatter.formatNutrientName(name);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toStringAsFixed(0),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'DM Sans',
              height: 1,
            ),
          ),
          const SizedBox(height: 2),

          Text(
            displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
              fontFamily: 'DM Sans',
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String extractUnit(String name) {
    if (name.toLowerCase().contains('mcg') ||
        name.toLowerCase().contains('µg')) {
      return 'mcg';
    }
    if (name.toLowerCase().contains('mg')) {
      return 'mg';
    }
    return 'mg';
  }

  String formatValue(double value, String unit) {
    if (value >= 1000) {
      return (value / 1).toStringAsFixed(0);
    } else if (value >= 100) {
      return value.toStringAsFixed(0);
    } else if (value >= 10) {
      return value.toStringAsFixed(0);
    } else {
      return value.toStringAsFixed(1);
    }
  }
}
