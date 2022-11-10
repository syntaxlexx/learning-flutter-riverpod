import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/providers/product_provider.dart';

class ErrorBody extends ConsumerWidget {
  final String message;

  const ErrorBody({required this.message, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () =>
                ref.refresh(productsProvider.notifier).getProducts(),
            child: const Text('Try again'),
          )
        ],
      ),
    );
  }
}
