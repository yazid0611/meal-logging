import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String name;
  final int quantity;
  final String unit;

  const IngredientEntity({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  IngredientEntity copyWith({
    String? name,
    int? quantity,
    String? unit,
  }) {
    return IngredientEntity(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [name, quantity, unit];
}
