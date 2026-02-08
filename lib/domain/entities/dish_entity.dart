import 'package:equatable/equatable.dart';
import 'package:meal_logging/domain/entities/ingredient_entity.dart';
import 'package:meal_logging/domain/entities/macros_entity.dart';

class DishEntity extends Equatable {
  final String dishName;
  final int confidence;
  final List<IngredientEntity> ingredients;
  final MacrosEntity? nutrition;
  final List<String> allergens;
  final String servingSize;

  const DishEntity({
    required this.dishName,
    required this.confidence,
    required this.ingredients,
    this.nutrition,
    required this.allergens,
    required this.servingSize,
  });

  DishEntity copyWith({
    String? dishName,
    int? confidence,
    List<IngredientEntity>? ingredients,
    MacrosEntity? nutrition,
    List<String>? allergens,
    String? servingSize,
  }) {
    return DishEntity(
      dishName: dishName ?? this.dishName,
      confidence: confidence ?? this.confidence,
      ingredients: ingredients ?? this.ingredients,
      nutrition: nutrition ?? this.nutrition,
      allergens: allergens ?? this.allergens,
      servingSize: servingSize ?? this.servingSize,
    );
  }

  @override
  List<Object?> get props => [
    dishName,
    confidence,
    ingredients,
    nutrition,
    allergens,
    servingSize,
  ];
}
