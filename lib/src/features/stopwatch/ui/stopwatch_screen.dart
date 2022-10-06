import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/timer.dart';
import '../data/providers/stopwatch_provider.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  static const route = '/stopwatch';

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('StopwatchScreen.build');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Card(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text('Timer with multiple providers'),
                    TimerTextWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonsContainer(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text('Timer with providers utilizing \'select\''),
                    TimerTextSelectWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonsSelectContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerTextWidget extends ConsumerWidget {
  const TimerTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerTextWidget.build');
    }

    final timeLeft = ref.watch(timeLeftProvider);

    return Text(
      timeLeft,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class TimerTextSelectWidget extends ConsumerWidget {
  const TimerTextSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerTextSelectWidget.build');
    }

    final timeLeft = ref.watch(timerProvider.select((timer) => timer.timeLeft));

    return Text(
      timeLeft,
      style: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
          ),
    );
  }
}

class ButtonsContainer extends ConsumerWidget {
  const ButtonsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('ButtonsContainer.build');
    }

    final state = ref.watch(buttonProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == ButtonState.initial) ...[
          const StartButton(),
        ],
        if (state == ButtonState.started) ...[
          const PauseButton(),
          const SizedBox(width: 20),
          const ResetButton(),
        ],
        if (state == ButtonState.paused) ...[
          const StartButton(),
          const SizedBox(width: 20),
          const ResetButton(),
        ],
        if (state == ButtonState.finished) ...[
          const ResetButton(),
        ],
      ],
    );
  }
}

class ButtonsSelectContainer extends ConsumerWidget {
  const ButtonsSelectContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('ButtonsSelectContainer.build');
    }

    final state = ref.watch(timerProvider.select((timer) => timer.buttonState));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == ButtonState.initial) ...[
          const StartButton(),
        ],
        if (state == ButtonState.started) ...[
          const PauseButton(),
          const SizedBox(width: 20),
          const ResetButton(),
        ],
        if (state == ButtonState.paused) ...[
          const StartButton(),
          const SizedBox(width: 20),
          const ResetButton(),
        ],
        if (state == ButtonState.finished) ...[
          const ResetButton(),
        ],
      ],
    );
  }
}

class StartButton extends ConsumerWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('StartButton.build');
    }

    final hero = 'start-${generateRandomString(3)}';

    return FloatingActionButton(
      heroTag: hero,
      onPressed: () {
        ref.read(timerProvider.notifier).start();
      },
      child: const Icon(Icons.play_arrow),
    );
  }
}

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('ResetButton.build');
    }

    final hero = 'reset-${generateRandomString(3)}';

    return FloatingActionButton(
      heroTag: hero,
      onPressed: () {
        ref.read(timerProvider.notifier).reset();
      },
      child: const Icon(Icons.replay),
    );
  }
}

class PauseButton extends ConsumerWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('PauseButton.build');
    }

    final hero = 'pause-${generateRandomString(3)}';

    return FloatingActionButton(
      heroTag: hero,
      onPressed: () {
        ref.read(timerProvider.notifier).pause();
      },
      child: const Icon(Icons.pause),
    );
  }
}
