import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'calculator_screen_controller.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  static const route = '/calculator';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('CalculatorScreen.build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Container(
        color: Colors.orange,
        child: Column(children: [
          Expanded(
            child: Container(
              color: Colors.orange,
            ),
          ),
          const DisplayText(),
          const SizedBox(
            height: 10,
          ),
          const ResultsText(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              CalculatorButton(text: '9'),
              CalculatorButton(text: '8'),
              CalculatorButton(text: '7'),
              CalculatorButton(text: '+'),
            ],
          ),
          Row(
            children: const [
              CalculatorButton(text: '6'),
              CalculatorButton(text: '5'),
              CalculatorButton(text: '4'),
              CalculatorButton(text: '-'),
            ],
          ),
          Row(
            children: const [
              CalculatorButton(text: '3'),
              CalculatorButton(text: '2'),
              CalculatorButton(text: '1'),
              CalculatorButton(text: 'x'),
            ],
          ),
          Row(
            children: const [
              CalculatorButton(text: 'C'),
              CalculatorButton(text: '0'),
              CalculatorButton(text: '='),
              CalculatorButton(text: '/'),
            ],
          ),
        ]),
      ),
    );
  }
}

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('CalculatorButton.build $text');

    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          ref.read(resultsProvider.notifier).calculate(text.toString());
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            text.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 25,
                ),
          ),
        ),
      ),
    );
  }
}

class ResultsText extends ConsumerWidget {
  const ResultsText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ResultsText.build');

    final result = ref.watch(resultsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          '$result',
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}

class DisplayText extends ConsumerWidget {
  const DisplayText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('DisplayText.build');

    final display = ref.watch(displayProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$display',
              style: Theme.of(context).textTheme.headline4,
            ),
            Divider(
              indent: display.toString().length + 20,
            ),
          ],
        ),
      ),
    );
  }
}
