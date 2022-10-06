import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

import '../models/calculator.dart';

class CalcColors {
  static const Color background1 = Color(0Xff22252d);
  static const Color background2 = Color(0xff292d36);
  static const Color background3 = Color(0xff272b33);
  static const Color operators = Color(0xfff57b7b);
  static const Color delete = Color(0xff26f4ce);
  static const Color numbers = Colors.white;
}

class Utils {
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = [
      '+',
      '-',
      '/',
      '÷',
      'x',
      '.',
      if (hasEquals) ...['=']
    ];

    return operators.contains(buttonText);
  }

  static bool isOperatorAtEnd(String equation) {
    if (equation.isNotEmpty) {
      return Utils.isOperator(equation.substring(equation.length - 1));
    }
    return false;
  }
}

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, Calculator>(
        (ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<Calculator> {
  CalculatorNotifier() : super(const Calculator());

  void append(String buttonText) {
    final equation = () {
      if (Utils.isOperator(buttonText) &&
          Utils.isOperatorAtEnd(state.equation)) {
        final newEquation =
            state.equation.substring(0, state.equation.length - 1);

        return newEquation + buttonText;
      } else if (state.shouldAppend) {
        return state.equation == '0' ? buttonText : state.equation + buttonText;
      }

      return Utils.isOperator(buttonText)
          ? state.equation + buttonText
          : buttonText;
    }();

    state = state.copy(equation: equation, shouldAppend: true);
    calculate();
  }

  void delete() {
    final equation = state.equation;

    if (equation.isNotEmpty) {
      final newEquation = equation.substring(0, equation.length - 1);

      if (newEquation.isEmpty) {
        reset();
      } else {
        state = state.copy(equation: newEquation);
        calculate();
      }
    }
  }

  void equals() {
    calculate();
    resetResult();
  }

  void calculate() {
    // replace illegal expressions
    final expression = state.equation.replaceAll('x', '*').replaceAll('÷', '/');

    try {
      final exp = Parser().parse(expression);
      final model = ContextModel();

      final result = '${exp.evaluate(EvaluationType.REAL, model)}';
      // copy current object with everything it had before, and set only results field
      state = state.copy(result: result);
      // ignore: empty_catches
    } catch (e) {}
  }

  void reset() {
    const equation = '0';
    const result = '0';

    state = state.copy(equation: equation, result: result);
  }

  void resetResult() {
    final equation = state.result;

    state = state.copy(equation: equation, shouldAppend: false);
  }
}
