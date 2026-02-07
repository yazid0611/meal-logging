import 'package:meal_logging/domain/entities/macros_entity.dart';

class MacrosModel {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double sugar;
  final double sodium;

  MacrosModel({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
    required this.sodium,
  });


  factory MacrosModel.fromJson(Map<String, dynamic> json) {
    return MacrosModel(
      calories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein_g'] as num?)?.toDouble() ?? 0.0,
      carbs: (json['carbs_g'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat_g'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar_g'] as num?)?.toDouble() ?? 0.0,
      sodium: (json['sodium_mg'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein_g': protein,
      'carbs_g': carbs,
      'fat_g': fat,
      'sugar_g': sugar,
      'sodium_mg': sodium,
    };
  }

  MacrosEntity toEntity() {
    return MacrosEntity(
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      sugar: sugar,
      sodium: sodium,
    );
  }
}
