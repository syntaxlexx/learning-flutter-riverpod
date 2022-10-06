import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers/movies_provider.dart';
import 'error_body.dart';
import 'movie_box.dart';

class MoviesPaginatedScreen extends ConsumerWidget {
  const MoviesPaginatedScreen({super.key});
  static const route = '/movies-paginated';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginationState =
        ref.watch(moviesPaginationNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies - Paginated'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (paginationState.state.refreshError) {
            return ErrorBody(message: '${paginationState.state.refreshError}');
          } else if (paginationState.state.movies.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .refresh(moviesPaginationNotifierProvider.notifier)
                  .getMovies();
            },
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: paginationState.state.movies.length,
              itemBuilder: (context, index) {
                // use the index for pagination
                paginationState.handleScrollWithIndex(index);

                return MovieBox(movie: paginationState.state.movies[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
