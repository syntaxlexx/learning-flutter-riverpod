import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/quiz_repository.dart';
import 'custom_button.dart';

class QuizError extends ConsumerWidget {
  final String message;

  const QuizError({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            title: 'Retry',
            onTap: () {
              ref.refresh(quizRepositoryProvider);
            },
          ),
        ],
      ),
    );
  }
}
