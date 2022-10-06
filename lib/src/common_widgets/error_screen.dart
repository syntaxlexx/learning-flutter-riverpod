import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  String? name;
  ErrorScreen({super.key, this.name});
  static const route = '/error';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('An error occurred'),
            name != null ? Text('$name') : Container(),
          ],
        ),
      ),
    );
  }
}
