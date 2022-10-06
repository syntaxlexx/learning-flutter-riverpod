import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/context_snackbar.dart';
import '../providers/timer_provider.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({Key? key}) : super(key: key);

  static const route = '/timer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerScreen.build');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto-Disposed Timer App w/ Limit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('The count is: '),
            SizedBox(
              height: 20,
            ),
            TimerDisplay(),
            SizedBox(
              height: 20,
            ),
            TimerCountdown(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: const TimerIncrement(),
    );
  }
}

class TimerDisplay extends ConsumerWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerDisplay.build');
    }

    final counter = ref.watch(counterProvider);
    final int limit = ref.watch(limitCountProvider);

    // ref.listen<AsyncValue<void>>(
    //   counterProvider,
    //   (_, state) => state.showSnackBarOnError(context),
    // );

    ref.listen(counterProvider, (prev, next) {
      int count = int.parse(next.toString());

      if (count >= limit) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exceeds limit of $limit')),
        );
      }
    });

    return Text('$counter');
  }
}

class TimerIncrement extends ConsumerWidget {
  const TimerIncrement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerIncrement.build');
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
  const TimerCountdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('TimerCountdown.build');
    }

    final stream = ref.watch(streamProvider);
    final int limit = ref.watch(limitCountProvider);

    ref.listen(streamProvider, (prev, next) {
      if (next.value! >= limit) {
        context.showSnackBar(context, message: 'Timer done at $limit');
      }
    });

    return stream.when(
      data: (data) => Text('Stream Provider: $data'),
      error: (error, stack) => Text('Error: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
