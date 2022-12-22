import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/difficulty.dart';
import '../models/failure.dart';
import '../models/question.dart';
import 'base_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseRepository {
  final _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions,
      required int categoryId,
      required Difficulty difficulty}) async {
    try {
      final queryParams = {
        'type': 'multiple',
        'amount': numQuestions,
        'category': categoryId
      };

      if (difficulty != Difficulty.any) {
        queryParams
            .addAll({'difficulty': EnumToString.convertToString(difficulty)});
      }

      final response = await _read(dioProvider)
          .get('https://opentdb.com/api.php', queryParameters: queryParams);

      if (response.statusCode == 200) {
        final data =
            Map<String, dynamic>.from(response.data as Map<dynamic, dynamic>);
        final results = List<Map<String, dynamic>>.from(
            data['results'] != null ? data['results'] as List : []);

        if (results.isNotEmpty) {
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }

      return [];
    } on DioError catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Failure(
          message: err.response?.statusMessage ?? 'An error occurred');
    } on SocketException catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw const Failure(message: 'Please check your connection');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw const Failure(message: 'Formating Error!');
    }
  }
}
