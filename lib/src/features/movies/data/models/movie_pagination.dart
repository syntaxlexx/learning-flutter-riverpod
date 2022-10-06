import 'dart:convert';

import 'package:collection/collection.dart';

import 'movie.dart';

class MoviePagination {
  final List<Movie> movies;
  final int page;
  final String errorMessage;

  MoviePagination.initial()
      : movies = [],
        page = 1,
        errorMessage = '';

  bool get refreshError => errorMessage != '' && movies.length <= 20;

  MoviePagination({
    required this.movies,
    required this.page,
    required this.errorMessage,
  });

  MoviePagination copyWith({
    List<Movie>? movies,
    int? page,
    String? errorMessage,
  }) {
    return MoviePagination(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movies': movies.map((x) => x.toMap()).toList(),
      'page': page,
      'errorMessage': errorMessage,
    };
  }

  factory MoviePagination.fromMap(Map<String, dynamic> map) {
    return MoviePagination(
      movies: List<Movie>.from(
        (map['movies'] as List<int>).map<Movie>(
          (x) => Movie.fromMap(x as Map<String, dynamic>),
        ),
      ),
      page: map['page'] as int,
      errorMessage: map['errorMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviePagination.fromJson(String source) =>
      MoviePagination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MoviePagination(movies: $movies, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(covariant MoviePagination other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.movies, movies) &&
        other.page == page &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => movies.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}
