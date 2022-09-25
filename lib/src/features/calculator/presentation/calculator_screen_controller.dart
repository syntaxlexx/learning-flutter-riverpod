import 'package:flutter_riverpod/flutter_riverpod.dart';

// first number
final firstNumberProvider = StateNotifierProvider<FirstNumberNotifier, String>(
    (ref) => FirstNumberNotifier(''));

class FirstNumberNotifier extends StateNotifier<String> {
  FirstNumberNotifier(super.state);

  void set(String value) {
    state = value;
  }
}

// second number
final secondNumberProvider =
    StateNotifierProvider.autoDispose<SecondNumberNotifier, String>(
        (ref) => SecondNumberNotifier(''));

class SecondNumberNotifier extends StateNotifier<String> {
  SecondNumberNotifier(super.state);

  void set(String value) {
    state = value;
  }
}

// operator
final operatorProvider =
    StateNotifierProvider.autoDispose<OperatorNotifier, String>(
        (ref) => OperatorNotifier(''));

class OperatorNotifier extends StateNotifier<String> {
  OperatorNotifier(super.state);

  void set(String value) {
    state = value;
  }
}

// display for the current calculation
final displayProvider =
    StateNotifierProvider.autoDispose<DisplayNotifier, String>(
        (ref) => DisplayNotifier(''));

class DisplayNotifier extends StateNotifier<String> {
  DisplayNotifier(super.state);

  void set(String value) {
    state = value;
  }
}

final resultsProvider =
    StateNotifierProvider.autoDispose<CalculationResults, String>(
        (ref) => CalculationResults(ref));

class CalculationResults extends StateNotifier<String> {
  CalculationResults(this.ref) : super('');

  final Ref ref;

  calculate(String value) {
    value = value.toLowerCase();
    final first = ref.read(firstNumberProvider);
    final second = ref.read(secondNumberProvider);
    final operator = ref.read(operatorProvider);
    final display = ref.read(displayProvider);

    if (value.toLowerCase() == 'c') {
      // reset all values
      ref.refresh(firstNumberProvider);
      ref.refresh(secondNumberProvider);
      ref.refresh(operatorProvider);
      ref.refresh(displayProvider);

      state = '';
      return;
    }

    if (['+', '-', '/', 'x'].contains(value)) {
      // ensure the first number exists first
      print('state: $state');
      ref.read(firstNumberProvider.notifier).set(state);
      ref.read(operatorProvider.notifier).set(value);
      ref.read(displayProvider.notifier).set('$state $value');
      state = ''; // reset state back

      print('op: $operator');
      print('first: $first');
      print('display: $display');

      return;
    }

    if (value == '=') {
      print('op: $operator');
      print('first: $first');
      print('display: $display');

      if (operator.isEmpty) {
        return;
      }

      // assign second number to current state
      ref.read(secondNumberProvider.notifier).state = state;
      ref.read(displayProvider.notifier).state =
          '$display $state ='; // 10 + 3 =

      double result = 0.0;

      switch (operator.toLowerCase()) {
        case 'x':
          result = (int.parse(first.toString()) * int.parse(second.toString()))
              as double;
          state = result.toStringAsFixed(0);
          break;
        case '-':
          result = (int.parse(first.toString()) - int.parse(second.toString()))
              as double;
          state = result.toStringAsFixed(0);
          break;
        case '/':
          result = (int.parse(first.toString()) / int.parse(second.toString()));
          state = result.toStringAsFixed(2);
          break;
        case '+':
          result = (int.parse(first.toString()) + int.parse(second.toString()))
              as double;
          state = result.toStringAsFixed(0);
          break;
      }

      ref.read(displayProvider.notifier).state =
          '$display $state'; // 10 + 3 = 5

      return;
    }

    // else user pressed a number that should be concatenated
    state = '$state$value';
  }
}
