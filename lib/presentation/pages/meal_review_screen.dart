import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/core/navigation/route_name.dart';
import 'package:meal_logging/presentation/bloc/ingredients/ingredients_bloc.dart';
import 'package:meal_logging/presentation/bloc/nutrition/nutrition_bloc.dart';
import 'package:meal_logging/presentation/widgets/shared/meal_loading_state.dart';
import 'package:meal_logging/presentation/widgets/meal_review/meal_review_body.dart';

class MealReviewScreen extends StatelessWidget {
  final String prompt;
  final bool useMockData;

  const MealReviewScreen({
    super.key,
    required this.prompt,
    this.useMockData = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          context.read<IngredientsBloc>()..add(AnalyzeMealEvent(prompt)),
      child: const MealReviewContent(),
    );
  }
}

class MealReviewContent extends StatelessWidget {
  const MealReviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Meal Review',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'DM Sans',
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<IngredientsBloc, IngredientsState>(
        listener: (context, state) {
          if (state.status == IngredientsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == IngredientsStatus.initial ||
              state.status == IngredientsStatus.loading) {
            return const MealLoadingWidget();
          }

          if (state.status == IngredientsStatus.loaded ||
              state.status == IngredientsStatus.modified) {
            return MealReviewBody(state: state);
          }

          return const Text('Unexpected state');
        },
      ),
      bottomNavigationBar: BlocBuilder<IngredientsBloc, IngredientsState>(
        builder: (context, state) {
          if (state.status == IngredientsStatus.loaded ||
              state.status == IngredientsStatus.modified) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => _onFinishLogging(context, state),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Finish Logging',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DM Sans',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _onFinishLogging(BuildContext context, IngredientsState state) {
    if (state.dish != null) {
      context.read<NutritionBloc>().add(GetNutritionEvent(state.dish!));
      context.pushNamed(
        RouteName.mealResult,
        extra: {'dishName': state.dish!.dishName},
      );
    }
  }
}
