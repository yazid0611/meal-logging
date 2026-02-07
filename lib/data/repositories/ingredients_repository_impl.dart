import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meal_logging/core/errors/failures.dart';
import 'package:meal_logging/data/models/dish_model.dart';
import 'package:meal_logging/data/sources/inredients_remote_datasource.dart';
import 'package:meal_logging/domain/entities/dish_entity.dart';
import 'package:meal_logging/domain/entities/nutrition_entity.dart';
import 'package:meal_logging/domain/repositories/ingredients_repository.dart';

class IngredientsRepositoryImpl implements IngredientsRepository {
  final IngredientsRemoteDataSourceImpl remoteDataSourceImpl;

  IngredientsRepositoryImpl({required this.remoteDataSourceImpl});

  @override
  Future<Either<Failure, DishEntity>> analyzeMeal(String prompt) async {
    try {
      final dishModel = await remoteDataSourceImpl.analyzeMeal(prompt);
      return Right(dishModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(message: 'Failed to analyze meal: ${e.message}'),
      );
    } catch (e) {
      return Left(UnknownFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, NutritionEntity>> getNutritionDetails(
    DishEntity dish,
  ) async {
    try {
      final dishModel = DishModel.fromEntity(dish);
      final nutritionModel = await remoteDataSourceImpl.getNutritionDetails(
        dishModel,
      );
      return Right(nutritionModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(message: 'Failed to get nutrition details: ${e.message}'),
      );
    } catch (e) {
      return Left(UnknownFailure(message: 'An unexpected error occurred: $e'));
    }
  }
}
