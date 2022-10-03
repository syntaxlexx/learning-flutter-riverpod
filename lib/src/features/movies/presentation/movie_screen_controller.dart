import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/movie.dart';
import '../data/services/movie_service.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;

  final movieService = ref.watch(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});
