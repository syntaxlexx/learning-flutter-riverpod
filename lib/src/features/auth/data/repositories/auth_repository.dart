import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/login_exception.dart';

abstract class AuthRepository {
  Future<String> login({
    required String email,
    required String password,
  });
}

class ApiAuthRepository implements AuthRepository {
  final Dio _dio;

  ApiAuthRepository(this._dio);

  @override
  Future<String> login(
      {required String email, required String password}) async {
    const url = 'https://reqres.in/api/login';

    try {
      final data = {
        'email': email,
        'password': password,
      };

      final response = await _dio.post(url, data: data);

      final token = response.data['token'] as String;
      return token;
    } on DioError catch (e) {
      throw LoginException(message: 'Unable to login');
    } catch (e) {
      throw Exception('Unable to login');
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ApiAuthRepository(Dio());
});
