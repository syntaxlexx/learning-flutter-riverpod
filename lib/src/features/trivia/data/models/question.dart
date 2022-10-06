import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> answers;

  const Question({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  @override
  List<Object?> get props =>
      [category, difficulty, question, correctAnswer, answers];

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      category: map['category'] != null ? map['category'].toString() : '',
      difficulty: map['difficulty'] != null ? map['difficulty'].toString() : '',
      question: map['question'] != null ? map['question'].toString() : '',
      correctAnswer:
          map['correct_answer'] != null ? map['correct_answer'].toString() : '',
      answers: List<String>.from(map['incorrect_answers'] as List)
        ..add('${map['correct_answer']}')
        ..shuffle(),
    );
  }
}
