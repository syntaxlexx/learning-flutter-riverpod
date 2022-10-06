import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers_provider.dart';

class ProvidersScreen extends ConsumerWidget {
  const ProvidersScreen({super.key});
  static const route = '/providers';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(textProvider);
    final future = ref.watch(futureProvider);
    final stream = ref.watch(streamProvider);
    final state = ref.watch(stateProvider);

    final stateNotifier = ref.watch(stateNotifierProvider);
    final changeNotifier = ref.watch(changeNotifierProvider);
    final stateNotifierAutodisposed = ref.watch(counterAutodisposedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Providers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Text Provider : $text'),
            const SizedBox(
              height: 20,
            ),
            future.when(
              data: (data) => Text('Future Provider: $data'),
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 20,
            ),
            stream.when(
              data: (data) => Text('Stream Provider: $data'),
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('State Provider: $state'),
            const SizedBox(
              height: 20,
            ),
            Text('State Notifier Provider: $stateNotifier'),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(stateNotifierProvider.notifier).add();
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(stateNotifierProvider.notifier).subtract();
                  },
                  child: const Text('Subtract'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Change Notifier Provider: ${changeNotifier.number}'),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(changeNotifierProvider.notifier).add();
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(changeNotifierProvider.notifier).subtract();
                  },
                  child: const Text('Subtract'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                'State Notifier Autodisposed Provider: $stateNotifierAutodisposed'),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterAutodisposedProvider.notifier).add();
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterAutodisposedProvider.notifier).subtract();
                  },
                  child: const Text('Subtract'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(stateProvider.state).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
