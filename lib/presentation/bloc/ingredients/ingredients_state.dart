part of 'ingredients_bloc.dart';

enum IngredientsStatus { initial, loading, loaded, modified, error }

class IngredientsState extends Equatable {
  final IngredientsStatus status;
  final DishEntity? dish;
  final String? errorMessage;

  const IngredientsState({
    this.status = IngredientsStatus.initial,
    this.dish,
    this.errorMessage,
  });

  List<IngredientEntity> get ingredients => dish?.ingredients ?? [];
  String get dishName => dish?.dishName ?? '';
  bool get hasIngredients => ingredients.isNotEmpty;

  IngredientsState copyWith({
    IngredientsStatus? status,
    DishEntity? dish,
    String? errorMessage,
  }) {
    return IngredientsState(
      status: status ?? this.status,
      dish: dish ?? this.dish,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, dish, errorMessage];
}
