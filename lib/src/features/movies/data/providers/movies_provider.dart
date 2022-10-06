import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/movies_exception.dart';
import '../models/movie.dart';
import '../models/movie_pagination.dart';
import '../repositories/movie_repository.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;

  final movieService = ref.watch(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});

// add pagination
final moviesPaginationNotifierProvider = StateNotifierProvider((ref) {
  final movieService = ref.read(movieServiceProvider);

  return MoviePaginationNotifier(movieService);
});

class MoviePaginationNotifier extends StateNotifier<MoviePagination> {
  final MovieRepository _service;

  MoviePaginationNotifier(
    this._service, [
    MoviePagination? state,
  ]) : super(state ?? MoviePagination.initial()) {
    getMovies();
  }

  Future<void> getMovies() async {
    try {
      final movies = await _service.getMovies(state.page);

      state = state
          .copyWith(movies: [...state.movies, ...movies], page: state.page + 1);
    } on MoviesException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;

    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getMovies();
    }
  }
}
