import 'package:dio/dio.dart';

class ProductsException implements Exception {
  String? message;

  ProductsException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.other:
        message = 'Connection to API server fiailed due to internet connection';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Received timeout in connection with API server';
        break;
      case DioErrorType.response:
        message = _handeError(dioError.response!.statusCode);
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  String _handeError(statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 404:
        return 'The requested resources was not found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Internal Server Error';
    }
  }

  @override
  String toString() => message.toString();
}
