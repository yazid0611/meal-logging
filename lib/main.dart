import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_logging/core/di/injection.dart';
import 'package:meal_logging/core/navigation/app_router.dart';
import 'package:meal_logging/core/theme/app_theme.dart';
import 'package:meal_logging/presentation/bloc/ingredients/ingredients_bloc.dart';
import 'package:meal_logging/presentation/bloc/nutrition/nutrition_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<IngredientsBloc>()),
        BlocProvider(create: (_) => sl<NutritionBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Meal Logging',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
