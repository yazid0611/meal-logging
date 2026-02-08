import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_logging/core/errors/failures.dart';
import 'package:meal_logging/domain/usecases/analyze_usecase.dart';
import '../../../domain/entities/dish_entity.dart';
import '../../../domain/entities/ingredient_entity.dart';
part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  final AnalyzeUsecase analyzeUsecase;

  IngredientsBloc(this.analyzeUsecase) : super(const IngredientsState()) {
    on<AnalyzeMealEvent>(onAnalyzeMeal);
    on<AddIngredientEvent>(onAddIngredient);
    on<UpdateIngredientEvent>(onUpdateIngredient);
    on<RemoveIngredientEvent>(onRemoveIngredient);
    on<ClearIngredientsEvent>(onClearIngredients);
    on<UpdateDishNameEvent>(onUpdateDishName);
  }

  Future<void> onAnalyzeMeal(
    AnalyzeMealEvent event,
    Emitter<IngredientsState> emit,
  ) async {
    emit(state.copyWith(status: IngredientsStatus.loading));

    final result = await analyzeUsecase(event.prompt);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: IngredientsStatus.error,
          errorMessage: mapFailureToMessage(failure),
        ),
      ),
      (dish) =>
          emit(state.copyWith(status: IngredientsStatus.loaded, dish: dish)),
    );
  }

  void onAddIngredient(
    AddIngredientEvent event,
    Emitter<IngredientsState> emit,
  ) {
    if (state.dish == null) return;
    final updatedIngredients = List<IngredientEntity>.from(state.ingredients)
      ..add(event.ingredient);
    final updatedDish = state.dish!.copyWith(ingredients: updatedIngredients);
    emit(state.copyWith(status: IngredientsStatus.modified, dish: updatedDish));
  }

  void onUpdateIngredient(
    UpdateIngredientEvent event,
    Emitter<IngredientsState> emit,
  ) {
    if (state.dish == null) return;
    final updatedIngredients = List<IngredientEntity>.from(state.ingredients)
      ..[event.index] = event.ingredient;
    final updatedDish = state.dish!.copyWith(ingredients: updatedIngredients);
    emit(state.copyWith(status: IngredientsStatus.modified, dish: updatedDish));
  }

  void onRemoveIngredient(
    RemoveIngredientEvent event,
    Emitter<IngredientsState> emit,
  ) {
    if (state.dish == null) return;
    final updatedIngredients = List<IngredientEntity>.from(state.ingredients)
      ..removeAt(event.index);
    final updatedDish = state.dish!.copyWith(ingredients: updatedIngredients);
    emit(state.copyWith(status: IngredientsStatus.modified, dish: updatedDish));
  }

  void onClearIngredients(
    ClearIngredientsEvent event,
    Emitter<IngredientsState> emit,
  ) {
    if (state.dish == null) return;
    emit(
      state.copyWith(
        status: IngredientsStatus.modified,
        dish: state.dish!.copyWith(ingredients: []),
      ),
    );
  }

  void onUpdateDishName(
    UpdateDishNameEvent event,
    Emitter<IngredientsState> emit,
  ) {
    if (state.dish == null) return;
    emit(
      state.copyWith(
        status: IngredientsStatus.modified,
        dish: state.dish!.copyWith(dishName: event.dishName),
      ),
    );
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return failure.message;
      case NetworkFailure _:
        return 'Please check your internet connection';
      case TimeoutFailure _:
        return 'Request timed out. Please try again';
      default:
        return failure.message;
    }
  }
}
