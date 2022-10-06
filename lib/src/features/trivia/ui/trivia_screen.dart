import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/enums/quiz_status.dart';
import '../data/models/failure.dart';
import '../data/models/question.dart';
import '../data/providers/trivia_provider.dart';
import 'custom_button.dart';
import 'quiz_error.dart';
import 'quiz_questions.dart';
import 'quiz_results.dart';

class TriviaScreen extends HookConsumerWidget {
  const TriviaScreen({super.key});
  static const route = '/trivia';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final quizQuestions = ref.watch(quizQuiestionsProvider);
    final pageController = usePageController();

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD4418E), Color(0xFF06525C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Trivia'),
        // ),
        backgroundColor: Colors.transparent,
        body: quizQuestions.when(
          data: (questions) => BuildQuestions(
            context: context,
            pageController: pageController,
            questions: questions,
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => QuizError(
            message: error is Failure ? error.message : 'Something went wrong!',
          ),
        ),
        bottomSheet: quizQuestions.maybeWhen(
          data: (questions) {
            final quizState = ref.watch(quizNotifierProvider);

            if (!quizState.answered) return const SizedBox.shrink();

            final pageIndex = pageController.page?.toInt() ?? 0;

            return CustomButton(
              title: pageIndex + 1 < questions.length
                  ? 'Next Question'
                  : 'See Results',
              onTap: () {
                ref
                    .read(quizNotifierProvider.notifier)
                    .nextQuestion(questions, pageIndex);

                if (pageIndex + 1 < questions.length) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  );
                }
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class BuildQuestions extends ConsumerWidget {
  final BuildContext context;
  final PageController pageController;
  final List<Question> questions;

  const BuildQuestions(
      {required this.context,
      required this.pageController,
      required this.questions,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (questions.isEmpty) {
      return const QuizError(message: 'No questions found');
    }

    final quizState = ref.watch(quizNotifierProvider);

    return quizState.status == QuizStatus.complete
        ? QuizResults(state: quizState, questions: questions)
        : QuizQuestions(
            pageController: pageController,
            state: quizState,
            questions: questions,
          );
  }
}
