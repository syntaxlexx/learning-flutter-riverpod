import 'package:dio/dio.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    var options = BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: 10000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options);
  }

  Dio get instance => _dio;
}
