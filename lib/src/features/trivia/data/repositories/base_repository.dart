import '../enums/difficulty.dart';
import '../models/question.dart';

abstract class BaseRepository {
  Future<List<Question>> getQuestions({
    required int numQuestions,
    required int categoryId,
    required Difficulty difficulty,
  });
}
