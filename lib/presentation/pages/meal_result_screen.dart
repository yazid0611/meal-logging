import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/presentation/bloc/nutrition/nutrition_bloc.dart';
import 'package:meal_logging/presentation/widgets/meal_result/meal_type_badge.dart';
import 'package:meal_logging/presentation/widgets/shared/app_button.dart';
import 'package:meal_logging/presentation/widgets/shared/custom_bar.dart';
import 'package:meal_logging/presentation/widgets/shared/error_state.dart';
import 'package:meal_logging/presentation/widgets/meal_result/macro_card.dart';
import 'package:meal_logging/presentation/widgets/shared/meal_loading_state.dart';

class MealResultScreen extends StatelessWidget {
  final String dishName;
  const MealResultScreen({
    super.key,
    required this.dishName,
    // required Map<String, dynamic> macros,
    // required Map<String, dynamic> micros,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Meal Summary',
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: BlocBuilder<NutritionBloc, NutritionState>(
          builder: (context, state) {
            if (state.status == NutritionStatus.loading) {
              return const MealLoadingWidget();
            }

            if (state.status == NutritionStatus.error) {
              return ErrorStateWidget(
                message: state.errorMessage ?? 'An error occurred',
                onRetry: () => context.pop(),
              );
            }

            final nutrition = state.nutrition;
            if (nutrition == null) {
              return const ErrorStateWidget(
                message: 'No nutrition data available',
              );
            }

            return MealResultContent(
              dishName: dishName,
              macros: nutrition.macros,
              micros: nutrition.micros,
            );
          },
        ),
      ),
    );
  }
}

class MealResultContent extends StatelessWidget {
  final String dishName;
  final dynamic macros;
  final dynamic micros;

  const MealResultContent({
    super.key,
    required this.dishName,
    required this.macros,
    required this.micros,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // Meal Header
          _MealHeader(dishName: dishName),

          const SizedBox(height: 24),

          // Meal Image Placeholder
          const _MealImagePlaceholder(),

          const SizedBox(height: 24),

          // Nutritional Breakdown Section
          _MacrosSection(macros: macros),

          const SizedBox(height: 24),

          // Key Micronutrients Section
          _MicrosSection(micros: micros),

          const SizedBox(height: 32),

          // Log More Button
          PrimaryButton(
            text: 'Log More',
            icon: Icons.add,
            onPressed: () => context.goNamed('logMeal'),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _MealHeader extends StatelessWidget {
  final String dishName;

  const _MealHeader({required this.dishName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dishName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'DM Sans',
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 12,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: 4),
            Text(
              DateFormat("MMMM d, yyyy 'at' h:mm a").format(DateTime.now()),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textTertiary,
                fontFamily: 'DM Sans',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const MealTypeBadge(mealType: 'Breakfast'),
      ],
    );
  }
}

class _MacrosSection extends StatelessWidget {
  final dynamic macros;

  const _MacrosSection({required this.macros});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Nutritional Breakdown'),
          subtitle: const Text(
            'This meal adds the following to your daily targets',
          ),
        ),
        const SizedBox(height: 16),

        // Top 3 macros - 3 column grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: [
            MacroNutrientCard(
              label: 'Calories',
              value: macros.calories.toStringAsFixed(0),
              unit: 'kcal',
              color: AppColors.calories,
              icon: Icons.local_fire_department,
            ),
            MacroNutrientCard(
              label: 'Protein',
              value: macros.protein.toStringAsFixed(0),
              unit: 'g',
              color: AppColors.protein,
              icon: Icons.fitness_center,
            ),
            MacroNutrientCard(
              label: 'Fat',
              value: macros.fat.toStringAsFixed(0),
              unit: 'g',
              color: AppColors.fat,
              icon: Icons.water_drop,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Bottom 3 macros - 2 column grid using compact cards
        Row(
          children: [
            Expanded(
              child: CompactMacroCard(
                label: 'Carbs',
                value: macros.carbs.toStringAsFixed(0),
                unit: 'g',
                color: AppColors.carbs,
                icon: Icons.grain,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CompactMacroCard(
                label: 'Sugar',
                value: macros.sugar.toStringAsFixed(0),
                unit: 'g',
                color: AppColors.sugar,
                icon: Icons.cookie,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MicrosSection extends StatelessWidget {
  final dynamic micros;

  const _MicrosSection({required this.micros});

  @override
  Widget build(BuildContext context) {
    final topMicros = micros.top6 as List;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Micronutrient',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'DM Sans',
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: topMicros.length,
          itemBuilder: (context, index) {
            final micro = topMicros[index];
            return MicronutrientCard(
              name: micro.key,
              value: micro.value.toDouble(),
            );
          },
        ),
      ],
    );
  }
}

class _MealImagePlaceholder extends StatelessWidget {
  const _MealImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: AppColors.textTertiary.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'Meal captured through input',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textTertiary.withOpacity(0.8),
              fontFamily: 'DM Sans',
            ),
          ),
        ],
      ),
    );
  }
}
