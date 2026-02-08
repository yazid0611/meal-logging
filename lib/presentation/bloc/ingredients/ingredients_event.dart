part of 'ingredients_bloc.dart';

abstract class IngredientsEvent extends Equatable {
  const IngredientsEvent();

  @override
  List<Object?> get props => [];
}

class AnalyzeMealEvent extends IngredientsEvent {
  final String prompt;

  const AnalyzeMealEvent(this.prompt);

  @override
  List<Object?> get props => [prompt];
}

class AddIngredientEvent extends IngredientsEvent {
  final IngredientEntity ingredient;

  const AddIngredientEvent(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class UpdateIngredientEvent extends IngredientsEvent {
  final int index;
  final IngredientEntity ingredient;

  const UpdateIngredientEvent({required this.index, required this.ingredient});

  @override
  List<Object?> get props => [index, ingredient];
}

class RemoveIngredientEvent extends IngredientsEvent {
  final int index;

  const RemoveIngredientEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ClearIngredientsEvent extends IngredientsEvent {
  const ClearIngredientsEvent();
}

class UpdateDishNameEvent extends IngredientsEvent {
  final String dishName;

  const UpdateDishNameEvent(this.dishName);

  @override
  List<Object?> get props => [dishName];
}
