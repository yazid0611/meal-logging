import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:meal_logging/core/network/dio_client.dart';
import 'package:meal_logging/data/repositories/ingredients_repository_impl.dart';
import 'package:meal_logging/data/sources/inredients_remote_datasource.dart';
import 'package:meal_logging/domain/repositories/ingredients_repository.dart';
import 'package:meal_logging/domain/usecases/analyze_usecase.dart';
import 'package:meal_logging/domain/usecases/get_nutrition.dart';
import 'package:meal_logging/presentation/bloc/ingredients/ingredients_bloc.dart';
import 'package:meal_logging/presentation/bloc/nutrition/nutrition_bloc.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<Dio>(() => sl<DioClient>().getDio());

  sl.registerLazySingleton<IngredientsRemoteDatasource>(
    () => IngredientsRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  sl.registerLazySingleton<IngredientsRepository>(
    () => IngredientsRepositoryImpl(
      remoteDataSource: sl<IngredientsRemoteDatasource>(),
    ),
  );

  sl.registerLazySingleton(
    () => AnalyzeUsecase(repository: sl<IngredientsRepository>()),
  );
  sl.registerLazySingleton(
    () => GetNutritionUseCase(repository: sl<IngredientsRepository>()),
  );
  sl.registerFactory(() => IngredientsBloc(sl<AnalyzeUsecase>()));
  sl.registerFactory(() => NutritionBloc(sl<GetNutritionUseCase>()));
}
