import 'package:meal_logging/data/models/macros_model.dart';
import 'package:meal_logging/data/models/micros_model.dart';
import 'package:meal_logging/domain/entities/nutrition_entity.dart';

class NutritionModel {
  final MacrosModel macros;
  final MicrosModel micros;

  NutritionModel({required this.macros, required this.micros});

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      macros: MacrosModel.fromJson(
        json['macros'] as Map<String, dynamic>? ?? {},
      ),
      micros: MicrosModel.fromJson(
        json['micros'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'macros': macros.toJson(), 'micros': micros.toJson()};
  }

  NutritionEntity toEntity() {
    return NutritionEntity(
      macros: macros.toEntity(),
      micros: micros.toEntity(),
    );
  }
}
