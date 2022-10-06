import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider.autoDispose((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

final limitCountProvider = StateProvider((ref) => 5);

final streamProvider = StreamProvider<int>((ref) {
  final int limit = ref.watch(limitCountProvider);

  return Stream.periodic(const Duration(seconds: 1), (number) => number + 1)
      .take(limit);
});
