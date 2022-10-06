import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/network_status/providers/network_status_provider.dart';

class ConnectivityWarning extends ConsumerWidget {
  const ConnectivityWarning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('ConnectivityWarning.build');
    }

    var network = ref.watch(networkAwareProvider);

    return network == NetworkStatus.off
        ? Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.red.shade500,
            child: Row(
              children: [
                Icon(
                  Icons.wifi_off,
                  color: Colors.grey.shade100,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'No internet connection',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade100),
                ),
              ],
            ),
          )
        : Container();
  }
}
