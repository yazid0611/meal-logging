part of 'nutrition_bloc.dart';

class NutritionEvent extends Equatable {
  const NutritionEvent();

  @override
  List<Object> get props => [];
}

class GetNutritionEvent extends NutritionEvent {
  final DishEntity dish;

  const GetNutritionEvent(this.dish);

  @override
  List<Object> get props => [dish];
}
