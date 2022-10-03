import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'websockets_screen_controller.dart';

class WebsocketsScreen extends ConsumerWidget {
  const WebsocketsScreen({super.key});
  static const route = '/websockets';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Websockets'),
      ),
      body: Center(
        child: messages.when(
          data: (data) {
            print(data);

            return Text(
              data,
              style: Theme.of(context).textTheme.headline5,
            );
          },
          error: (error, _) {
            print(error);
            return const Text('Probably server not running.');
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
