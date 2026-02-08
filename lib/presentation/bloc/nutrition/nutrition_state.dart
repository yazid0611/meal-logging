part of 'nutrition_bloc.dart';

enum NutritionStatus { initial, loading, loaded, error }

class NutritionState extends Equatable {
  final NutritionStatus status;
  final NutritionEntity? nutrition;
  final String? errorMessage;

  const NutritionState({
    this.status = NutritionStatus.initial,
    this.nutrition,
    this.errorMessage,
  });

  NutritionState copyWith({
    NutritionStatus? status,
    NutritionEntity? nutrition,
    String? errorMessage,
  }) {
    return NutritionState(
      status: status ?? this.status,
      nutrition: nutrition ?? this.nutrition,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, nutrition, errorMessage];
}
