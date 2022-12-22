import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/models/question.dart';
import '../data/models/quiz_state.dart';
import '../data/providers/trivia_provider.dart';
import '../data/repositories/quiz_repository.dart';
import 'confetti_card.dart';
import 'custom_button.dart';

class QuizResults extends ConsumerWidget {
  final QuizState state;
  final List<Question> questions;

  const QuizResults({required this.state, required this.questions, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: state.correct.length == questions.length
                  ? const ConfettiCard()
                  : Container(),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${state.correct.length} / ${questions.length}',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              'CORRECT',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                  ),
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
        ),
      ],
    );
  }
}
