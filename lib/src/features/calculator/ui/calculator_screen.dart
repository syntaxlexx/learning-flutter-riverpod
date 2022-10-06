import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/providers/calculator_provider.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  static const route = '/calculator';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('CalculatorScreen.build');
    }

    return Scaffold(
      backgroundColor: CalcColors.background1,
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildResults(),
            ),
            Expanded(
              flex: 2,
              child: buildButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CalcColors.background2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: const [
            BuildButton('AC', '<', '', '÷'),
            BuildButton('7', '8', '9', 'x'),
            BuildButton('4', '5', '6', '-'),
            BuildButton('1', '2', '3', '+'),
            BuildButton('0', '.', '', '='),
          ],
        ),
      );

  Widget buildResults() => Consumer(builder: (context, ref, child) {
        if (kDebugMode) {
          print('buildResults');
        }

        final state = ref.watch(calculatorProvider);

        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                state.equation,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  height: 1,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                state.result,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ],
          ),
        );
      });
}

class BuildButton extends ConsumerWidget {
  final String first;
  final String second;
  final String third;
  final String fourth;

  const BuildButton(this.first, this.second, this.third, this.fourth,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('BuildButton.build $first');
    }
    final row = [first, second, third, fourth];

    return Expanded(
      child: Row(
        children: row
            .map(
              (text) => ButtonWidget(
                text: text,
                onClicked: () {
                  final calc = ref.read(calculatorProvider.notifier);

                  switch (text) {
                    case '=':
                      calc.equals();
                      break;
                    case '<':
                      calc.delete();
                      break;
                    case 'AC':
                      calc.reset();
                      break;
                    default:
                      calc.append(text);
                      break;
                  }
                },
                onClickedLong: () {
                  final calc = ref.read(calculatorProvider.notifier);
                  switch (text) {
                    case '<':
                      calc.reset();
                      break;
                    default:
                      break;
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final VoidCallback onClickedLong;

  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onClicked,
      required this.onClickedLong});

  @override
  Widget build(BuildContext context) {
    final color = getTextColor(text);
    final double fontSize = Utils.isOperator(
      text,
      hasEquals: true,
    )
        ? 26
        : 22;

    final style = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    return Expanded(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onClicked,
          onLongPress: onClickedLong,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: CalcColors.background3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: text == '<'
              ? Icon(Icons.backspace_outlined, color: color)
              : Text(
                  text,
                  style: style,
                ),
        ),
      ),
    );
  }

  Color getTextColor(String buttonText) {
    switch (buttonText) {
      case '+':
      case '-':
      case 'x':
      case '=':
      case '/':
      case '÷':
        return CalcColors.operators;
      case 'AC':
      case '<':
        return CalcColors.delete;
      default:
        return CalcColors.numbers;
    }
  }
}
