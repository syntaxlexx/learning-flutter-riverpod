import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/counter_provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  static const route = '/counter';

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('CounterScreen.build');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto-Disposed Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CounterLabel(),
            const CounterDisplay(),
            const SizedBox(
              height: 20,
            ),
            TimerCountdown(),
          ],
        ),
      ),
      floatingActionButton: const CounterIncrement(),
    );
  }
}

class CounterLabel extends ConsumerWidget {
  const CounterLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('CounterLabel.build');
    }
    return const Text('The count is: ');
  }
}

class CounterDisplay extends ConsumerWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('CounterDisplay.build');
    }

    final counter = ref.watch(counterProvider);

    return Text('$counter');
  }
}

class CounterIncrement extends ConsumerWidget {
  const CounterIncrement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('CounterIncrement.build');
    }

    return FloatingActionButton(
      onPressed: () {
        ref.read(counterProvider.notifier).increment();
      },
      child: const Icon(Icons.add),
    );
  }
}

class TimerCountdown extends ConsumerWidget {
  TimerCountdown({super.key});

  final _numbers = numbers();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerCountdown.build');
    }

    return StreamBuilder(
      stream: _numbers,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return Text('Countdown: ${snapshot.data}');
          case ConnectionState.done:
            return SelectableText('Done at: ${snapshot.data}');
          default:
            return Container();
        }
      },
    );
  }
}
