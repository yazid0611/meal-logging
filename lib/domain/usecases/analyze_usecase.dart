import 'package:dartz/dartz.dart';
import 'package:meal_logging/core/errors/failures.dart';
import 'package:meal_logging/domain/entities/dish_entity.dart';
import 'package:meal_logging/domain/repositories/ingredients_repository.dart';

class AnalyzeUsecase {
  final IngredientsRepository repository;

  AnalyzeUsecase({required this.repository});

  Future<Either<Failure, DishEntity>> call(String prompt) {
    return repository.analyzeMeal(prompt);
  }
}
