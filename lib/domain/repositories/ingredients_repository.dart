import 'package:meal_logging/core/errors/failures.dart';
import 'package:meal_logging/domain/entities/dish_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meal_logging/domain/entities/nutrition_entity.dart';

abstract class IngredientsRepository {
  Future<Either<Failure, DishEntity>> analyzeMeal(String prompt);
  Future<Either<Failure, NutritionEntity>> getNutritionDetails(DishEntity dish);
}
