import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/exceptions/movies_exception.dart';
import '../data/providers/movies_provider.dart';
import 'error_body.dart';
import 'movie_box.dart';

class MoviesScreen extends ConsumerWidget {
  const MoviesScreen({super.key});
  static const route = '/movies';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 12),
        child: movies.when(
          data: (data) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(moviesFutureProvider);
              },
              child: GridView.extent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
                children: data.map((movie) => MovieBox(movie: movie)).toList(),
              ),
            );
          },
          error: (error, _) {
            if (error is MoviesException) {
              return ErrorBody(message: '${error.message}');
            }

            return const ErrorBody(
                message: 'Oops, something unexpected happened');
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
