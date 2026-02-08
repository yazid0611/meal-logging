import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_logging/core/navigation/route_name.dart';
import 'package:meal_logging/core/navigation/route_path.dart';
import 'package:meal_logging/presentation/pages/log_meal_screen.dart';
import 'package:meal_logging/presentation/pages/meal_result_screen.dart';
import 'package:meal_logging/presentation/pages/meal_review_screen.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: RoutePath.logMeal,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePath.logMeal,
        name: RouteName.logMeal,
        builder: (context, state) => const LogMealScreen(),
      ),
      GoRoute(
        path: RoutePath.mealReview,
        name: RouteName.mealReview,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          return MealReviewScreen(
            prompt: extras?['prompt'] ?? '',
            useMockData: true,
          );
        },
      ),
      GoRoute(
        path: RoutePath.mealResult,
        name: RouteName.mealResult,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          return MealResultScreen(
            dishName: extras?['dishName'] ?? 'Unknown Meal',
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.name}'))),
  );
}
