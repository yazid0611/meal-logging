import 'package:meal_logging/core/constants/api_constants.dart';
import 'package:meal_logging/data/models/dish_model.dart';
import 'package:meal_logging/data/models/nutrition_model.dart';
import 'package:dio/dio.dart';

abstract class InredientsRemoteDatasource {
  Future<DishModel> analyzeMeal(String prompt);
  Future<NutritionModel> getNutritionDetails(DishModel dish);
}

class IngredientsRemoteDataSourceImpl implements InredientsRemoteDatasource {
  final Dio dio;

  IngredientsRemoteDataSourceImpl({required this.dio});

  @override
  Future<DishModel> analyzeMeal(String prompt) {
    final response = dio.post(
      ApiConstants.ingredientsEndpoint,
      data: {'prompt': prompt, 'minio': false},
    );

    final dishModel = response.then((res) {
      if (res.statusCode == 200) {
        final data = res.data as Map<String, dynamic>;
        final dishes = data['dishes'] as List<dynamic>?;
        if (dishes == null || dishes.isEmpty) {
          throw Exception('No dishes found');
        }
        return DishModel.fromJson(dishes.first as Map<String, dynamic>);
      } else {
        throw Exception('Failed to analyze meal: ${res.statusCode}');
      }
    });
    return dishModel;
  }

  @override
  Future<NutritionModel> getNutritionDetails(DishModel dish) {
    final response = dio.post(
      ApiConstants.nutrientsMicroEndpoint,
      data: {
        'food_name': dish.dishName,
        'dishes': [dish.toJson()],
        'drinks': [],
      },
    );

    final nutritionModel = response.then((res) {
      if (res.statusCode == 200) {
        final data = res.data as Map<String, dynamic>;
        final total = data['total'] as Map<String, dynamic>?;
        if (total == null) {
          throw Exception('No nutrients found');
        }

        final macros = total['macros'] as Map<String, dynamic>?;
        final micros = total['micros'] as Map<String, dynamic>?;

        if (macros == null || micros == null) {
          throw Exception('Incomplete nutrition data');
        }
        return NutritionModel.fromJson({'macros': macros, 'micros': micros});
      } else {
        throw Exception('Failed to get nutrition details: ${res.statusCode}');
      }
    });
    return nutritionModel;
  }
}
