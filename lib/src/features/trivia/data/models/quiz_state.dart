import 'package:equatable/equatable.dart';

import '../enums/quiz_status.dart';
import 'question.dart';

class QuizState extends Equatable {
  final QuizStatus status;
  final String selectedAnswer;
  final List<Question> correct; // correctly answered questions
  final List<Question> incorrect; // incorrectly answered questions

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState({
    required this.status,
    required this.selectedAnswer,
    required this.correct,
    required this.incorrect,
  });

  factory QuizState.initial() {
    return const QuizState(
      status: QuizStatus.initial,
      selectedAnswer: '',
      correct: [],
      incorrect: [],
    );
  }

  @override
  List<Object?> get props => [
        status,
        correct,
        incorrect,
        selectedAnswer,
      ];

  QuizState copyWith(
      {String? selectedAnswer,
      List<Question>? correct,
      List<Question>? incorrect,
      QuizStatus? status}) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      status: status ?? this.status,
    );
  }
}
