import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../environment_config.dart';
import '../exceptions/movies_exception.dart';
import '../models/movie.dart';

const String moviesUrl = 'https://api.themoviedb.org/3/movie';

final movieServiceProvider = Provider<MovieService>((ref) {
  final config = ref.watch(environmentConfigProvider);

  return MovieService(config, Dio());
});

class MovieService {
  final Dio _dio;
  final EnvironmentConfig _environmentConfig;

  MovieService(this._environmentConfig, this._dio);

  Future<List<Movie>> getMovies([int page = 1]) async {
    try {
      final url =
          '$moviesUrl/popular?api_key=${_environmentConfig.movieApiKey}&language=en-US&page=$page';
      final response = await _dio.get(url);

      final results =
          List<Map<String, dynamic>>.from(response.data['results'] as Iterable);

      List<Movie> movies =
          results.map((e) => Movie.fromMap(e)).toList(growable: false);

      return movies;
    } on DioError catch (e) {
      throw MoviesException.fromDioError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
