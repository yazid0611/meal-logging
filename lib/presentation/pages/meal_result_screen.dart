import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/presentation/bloc/nutrition/nutrition_bloc.dart';
import 'package:meal_logging/presentation/widgets/meal_result/meal_header.dart';
import 'package:meal_logging/presentation/widgets/meal_result/meal_image_placeholder.dart';
import 'package:meal_logging/presentation/widgets/meal_result/nutritional_breakdown_section.dart';
import 'package:meal_logging/presentation/widgets/meal_result/key_micronutrients_section.dart';
import 'package:meal_logging/presentation/widgets/shared/app_button.dart';
import 'package:meal_logging/presentation/widgets/shared/custom_bar.dart';
import 'package:meal_logging/presentation/widgets/shared/error_state.dart';
import 'package:meal_logging/presentation/widgets/shared/meal_loading_state.dart';

class MealResultScreen extends StatelessWidget {
  final String dishName;

  const MealResultScreen({super.key, required this.dishName});

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            MealHeader(dishName: dishName),
            const SizedBox(height: 20),
            const MealImagePlaceholder(),
            const SizedBox(height: 20),
            NutritionalBreakdownSection(macros: macros),
            const SizedBox(height: 16),
            KeyMicronutrientsSection(micros: micros),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Log More',
              icon: Icons.add_circle_outline_rounded,
              onPressed: () => context.goNamed('logMeal'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
