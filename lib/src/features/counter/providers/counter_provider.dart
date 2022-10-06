import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider.autoDispose((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

Stream<int> numbers() =>
    Stream.periodic(const Duration(seconds: 1), (e) => e + 1).take(10);
