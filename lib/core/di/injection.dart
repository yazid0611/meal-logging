import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:meal_logging/core/network/dio_client.dart';
import 'package:meal_logging/data/repositories/ingredients_repository_impl.dart';
import 'package:meal_logging/data/sources/inredients_remote_datasource.dart';
import 'package:meal_logging/domain/repositories/ingredients_repository.dart';
import 'package:meal_logging/domain/usecases/analyze_usecase.dart';
import 'package:meal_logging/domain/usecases/get_nutrition.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<Dio>(() => sl<DioClient>().getDio());

  sl.registerLazySingleton<InredientsRemoteDatasource>(
    () => IngredientsRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<IngredientsRepository>(
    () => IngredientsRepositoryImpl(remoteDataSourceImpl: sl()),
  );

  sl.registerLazySingleton(() => AnalyzeUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetNutritionUseCase(repository: sl()));
}
