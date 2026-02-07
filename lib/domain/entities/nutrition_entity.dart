import 'package:equatable/equatable.dart';
import 'package:meal_logging/domain/entities/macros_entity.dart';
import 'package:meal_logging/domain/entities/micros_entity.dart';

class NutritionEntity extends Equatable {
  final MacrosEntity macros;
  final MicrosEntity micros;

  const NutritionEntity({required this.macros, required this.micros});

  @override
  List<Object?> get props => [macros, micros];
}
