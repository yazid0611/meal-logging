import 'package:dartz/dartz.dart';
import 'package:meal_logging/core/errors/failures.dart';
import 'package:meal_logging/domain/entities/dish_entity.dart';
import 'package:meal_logging/domain/entities/nutrition_entity.dart';
import 'package:meal_logging/domain/repositories/ingredients_repository.dart';

class GetNutritionUseCase {
  final IngredientsRepository repository;

  GetNutritionUseCase({required this.repository});

  Future<Either<Failure, NutritionEntity>> call(DishEntity dish) {
    return repository.getNutritionDetails(dish);
  }
}
