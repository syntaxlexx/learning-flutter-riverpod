import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers/movies_provider.dart';

class ErrorBody extends ConsumerWidget {
  final String message;

  const ErrorBody({required this.message, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => ref
                .refresh(moviesPaginationNotifierProvider.notifier)
                .getMovies(),
            child: const Text('Try again'),
          )
        ],
      ),
    );
  }
}
