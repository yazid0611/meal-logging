import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_logging/domain/usecases/get_nutrition.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/dish_entity.dart';
import '../../../domain/entities/nutrition_entity.dart';
import '../../../domain/entities/macros_entity.dart';
import '../../../domain/entities/micros_entity.dart';

part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final GetNutritionUseCase getNutritionUseCase;

  NutritionBloc(this.getNutritionUseCase) : super(const NutritionState()) {
    on<GetNutritionEvent>(onGetNutrition);
    on<ClearNutritionEvent>(onClearNutrition);
  }

  Future<void> onGetNutrition(
    GetNutritionEvent event,
    Emitter<NutritionState> emit,
  ) async {
    emit(state.copyWith(status: NutritionStatus.loading));
    final result = await getNutritionUseCase(event.dish);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NutritionStatus.error,
          errorMessage: mapFailureToMessage(failure),
        ),
      ),
      (nutrition) => emit(
        state.copyWith(status: NutritionStatus.loaded, nutrition: nutrition),
      ),
    );
  }

  void onClearNutrition(ClearNutritionEvent event, Emitter emit) {
    emit(const NutritionState());
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
        return 'An unexpected error occurred';
    }
  }
}
