import '../domain/enums/difficulty.dart';
import '../domain/models/question.dart';

abstract class BaseRepository {
  Future<List<Question>> getQuestions({
    required int numQuestions,
    required int categoryId,
    required Difficulty difficulty,
  });
}
