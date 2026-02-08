import 'package:meal_logging/data/models/ingredient_model.dart';
import 'package:meal_logging/data/models/macros_model.dart';
import 'package:meal_logging/domain/entities/dish_entity.dart';

class DishModel {
  final String dishName;
  final int confidence;
  final List<IngredientModel> ingredients;
  final MacrosModel? nutrition;
  final List<String> allergens;
  final String servingSize;

  DishModel({
    required this.dishName,
    required this.confidence,
    required this.ingredients,
    this.nutrition,
    required this.allergens,
    required this.servingSize,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      dishName: json['dish_name'] ?? 'Unknown Dish',
      confidence: json['confidence'],
      ingredients:
          (json['ingredients'] as List<dynamic>?)
              ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nutrition: json['nutrition'] != null
          ? MacrosModel.fromJson(json['nutrition'] as Map<String, dynamic>)
          : null,
      allergens:
          (json['allergens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      servingSize: json['serving_size'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dish_name': dishName,
      'confidence': confidence,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'nutrition': nutrition?.toJson(),
      'allergens': allergens,
      'serving_size': servingSize,
    };
  }

  DishEntity toEntity() {
    return DishEntity(
      dishName: dishName,
      confidence: confidence,
      ingredients: ingredients.map((e) => e.toEntity()).toList(),
      nutrition: nutrition?.toEntity(),
      allergens: allergens,
      servingSize: servingSize,
    );
  }

  factory DishModel.fromEntity(DishEntity entity) {
    return DishModel(
      dishName: entity.dishName,
      confidence: entity.confidence,
      ingredients: entity.ingredients
          .map((e) => IngredientModel.fromEntity(e))
          .toList(),
      nutrition: entity.nutrition != null
          ? MacrosModel(
              calories: entity.nutrition!.calories,
              protein: entity.nutrition!.protein,
              carbs: entity.nutrition!.carbs,
              fat: entity.nutrition!.fat,
              sugar: entity.nutrition!.sugar,
              sodium: entity.nutrition!.sodium,
            )
          : null,
      allergens: entity.allergens,
      servingSize: entity.servingSize,
    );
  }
}
