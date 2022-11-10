import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../exceptions/products_exception.dart';
import '../models/product.dart';

var logger = Logger();

abstract class ProductRepository {
  Future<List<Product>> getProducts([int page = 1]);

  Future<Product> getProduct(int id);

  Future<void> likeProduct(int id);

  Future<void> recordView(int id);
}

class ApiProductRepository implements ProductRepository {
  final Dio _dio;
  final limit = 20;
  final baseUrl = 'https://dummyjson.com';

  ApiProductRepository(this._dio);

  @override
  Future<List<Product>> getProducts([int page = 1]) async {
    try {
      final url = '$baseUrl/products?limit=${limit}&skip=${page * limit}';
      final response = await _dio.get(url);

      final results = List<Map<String, dynamic>>.from(
          response.data['products'] as Iterable);

      List<Product> list =
          results.map((e) => Product.fromMap(e)).toList(growable: false);

      return list;
    } on DioError catch (e) {
      throw ProductsException.fromDioError(e);
    } catch (e) {
      logger.d(e);
      throw Exception(e.toString());
    }
  }

  @override
  Future<Product> getProduct(int id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<void> likeProduct(int id) {
    // TODO: implement likeProduct
    throw UnimplementedError();
  }

  @override
  Future<void> recordView(int id) {
    // TODO: implement recordView
    throw UnimplementedError();
  }
}
