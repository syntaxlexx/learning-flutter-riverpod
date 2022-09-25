import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_status_screen_controller.dart';

class NetworkStatusScreen extends ConsumerWidget {
  const NetworkStatusScreen({super.key});

  static const route = '/network-status';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('NetworkStatusScreen.build');

    var network = ref.watch(networkAwareProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Status'),
      ),
      body: network == NetworkStatus.Off
          ? const Center(
              child: Text('No Internet'),
            )
          : const Center(
              child: Text('Internet is on'),
            ),
    );
  }
}
