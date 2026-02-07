import 'package:get_it/get_it.dart';
import 'package:meal_logging/core/network/dio_client.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  sl.registerSingleton(DioClient());
  sl.registerSingleton(sl<DioClient>().getDio());
}
