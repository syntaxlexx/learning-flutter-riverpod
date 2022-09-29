import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/question.dart';
import '../repositories/quiz_repository.dart';
import 'custom_button.dart';
import 'state/quiz_state.dart';
import 'trivia_screen_controller.dart';

class QuizResults extends ConsumerWidget {
  final QuizState state;
  final List<Question> questions;

  const QuizResults({ required this.state, required this.questions, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.correct.length} / ${questions.length}',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        Text(
          'CORRECT',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          title: 'New Quiz',
          onTap: () {
            ref.refresh(quizRepositoryProvider);
            ref.read(quizNotifierProvider.notifier).reset();
          },
        ),
      ],
    );
  }
}
