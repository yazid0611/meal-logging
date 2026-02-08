import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/domain/entities/micros_entity.dart';
import 'package:meal_logging/presentation/widgets/meal_result/micro_nutrient_card.dart';

class KeyMicronutrientsSection extends StatelessWidget {
  final MicrosEntity micros;

  const KeyMicronutrientsSection({super.key, required this.micros});

  @override
  Widget build(BuildContext context) {
    final nutrientEntries = micros.nutrients.entries.toList();

    // Sort by value in descending order (highest first)
    nutrientEntries.sort((a, b) => b.value.compareTo(a.value));

    // Take only top 6 nutrients
    final top6Nutrients = nutrientEntries.take(6).toList();

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
            'Key Micronutrient',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'DM Sans',
            ),
          ),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemCount: top6Nutrients.length,
            itemBuilder: (context, index) {
              final entry = top6Nutrients[index];
              return MicronutrientCard(name: entry.key, value: entry.value);
            },
          ),
        ],
      ),
    );
  }
}
