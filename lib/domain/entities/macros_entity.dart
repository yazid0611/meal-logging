import 'package:equatable/equatable.dart';

class MacrosEntity extends Equatable {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double sugar;
  final double sodium;

  const MacrosEntity({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
    required this.sodium,
  });

  @override
  List<Object?> get props => [calories, protein, carbs, fat, sugar, sodium];
}
