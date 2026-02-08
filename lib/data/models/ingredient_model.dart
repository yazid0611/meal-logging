import 'package:meal_logging/domain/entities/ingredient_entity.dart';

class IngredientModel {
  final String name;
  final int quantity;
  final String unit;

  IngredientModel({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'] ?? '',
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'unit': unit};
  }

  IngredientEntity toEntity() {
    return IngredientEntity(name: name, quantity: quantity, unit: unit);
  }

  factory IngredientModel.fromEntity(IngredientEntity entity) {
    return IngredientModel(
      name: entity.name,
      quantity: entity.quantity,
      unit: entity.unit,
    );
  }

  IngredientModel copyWith({String? name, int? quantity, String? unit}) {
    return IngredientModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}
