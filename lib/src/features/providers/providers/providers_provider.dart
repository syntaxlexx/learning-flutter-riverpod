import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider = Provider<String>((ref) => 'Hello');

final futureProvider = FutureProvider<int>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return 3;
});

final streamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (number) {
    if (number < 5) return number + 1;
    return 5;
  });
});

final stateProvider = StateProvider<int>((ref) => 0);

final stateNotifierProvider =
    StateNotifierProvider<CountNotifier, int>((ref) => CountNotifier(6));

class CountNotifier extends StateNotifier<int> {
  CountNotifier(super.state);

  void add() {
    state += 1;
  }

  void subtract() {
    state -= 1;
  }
}

final changeNotifierProvider =
    ChangeNotifierProvider<ChangeCount>((ref) => ChangeCount());

class ChangeCount extends ChangeNotifier {
  int number = 6;

  void add() {
    number += 1;
    notifyListeners();
  }

  void subtract() {
    number -= 1;
    notifyListeners();
  }
}

final counterAutodisposedProvider =
    StateNotifierProvider.autoDispose((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void add() => state++;
  void subtract() => state--;
}
