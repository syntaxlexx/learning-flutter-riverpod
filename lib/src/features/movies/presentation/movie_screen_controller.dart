import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/exceptions/movies_exception.dart';
import '../data/models/movie.dart';
import '../data/models/movie_pagination.dart';
import '../data/services/movie_service.dart';

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
  final MovieService _service;

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

    print(
        'requestMoreData: $requestMoreData pageToRequest $pageToRequest state.page ${state.page}');

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      print('fetching...');
      getMovies();
    }
  }
}
