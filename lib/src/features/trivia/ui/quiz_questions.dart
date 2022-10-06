import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';

import '../data/models/question.dart';
import '../data/models/quiz_state.dart';
import '../data/providers/trivia_provider.dart';
import 'answer_card.dart';

class QuizQuestions extends ConsumerWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions(
      {super.key,
      required this.pageController,
      required this.state,
      required this.questions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: ((context, index) {
        final question = questions[index];

        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Question ${index + 1} of ${questions.length}',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              HtmlCharacterEntities.decode(question.question),
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            height: 32,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Column(
            children: question.answers
                .map(
                  (e) => AnswerCard(
                    answer: e,
                    // ignore: unrelated_type_equality_checks
                    isSelected: e == state.selectedAnswer,
                    // ignore: unrelated_type_equality_checks
                    isCorrect: e == question.correctAnswer,
                    isDisplayingAnswer: state.answered,
                    onTap: () {
                      ref
                          .read(quizNotifierProvider.notifier)
                          .submitAnswer(question, e);
                    },
                  ),
                )
                .toList(),
          ),
        ]);
      }),
    );
  }
}
