class ApiConstants {
  ApiConstants._();

  static const String port = '8002';
  static const String baseUrl = 'http://192.168.1.6:$port';
  // static const String baseUrl = 'http://40.89.185.79:$port';

  static const String ingredientsEndpoint = '/v4/ingredients';
  static const String nutrientsMicroEndpoint = '/v5/nutrients/micro';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
