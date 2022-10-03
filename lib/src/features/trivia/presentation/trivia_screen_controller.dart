import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/enums/difficulty.dart';
import '../domain/enums/quiz_status.dart';
import '../domain/models/question.dart';
import '../repositories/quiz_repository.dart';
import 'state/quiz_state.dart';

final quizNotifierProvider =
    StateNotifierProvider.autoDispose<QuizNotifier, QuizState>(
        (ref) => QuizNotifier(QuizState.initial()));

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(super.state);

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;

    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: [...state.correct, currentQuestion],
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        incorrect: [...state.incorrect, currentQuestion],
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}

final quizQuiestionsProvider = FutureProvider.autoDispose<List<Question>>(
  (ref) => ref.watch(quizRepositoryProvider).getQuestions(
        numQuestions: 5,
        categoryId: Random().nextInt(24) + 9,
        difficulty: Difficulty.any,
      ),
);
