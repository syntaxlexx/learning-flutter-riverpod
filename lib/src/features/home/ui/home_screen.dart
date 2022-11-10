import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common_widgets/connectivity_warning.dart';
import '../../../utils/contants.dart';
import '../data/providers/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeMenuEntries = ref.watch(homeMenuEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
      ),
      body: ListView(
        children: [
          const ConnectivityWarning(),
          Column(
            children: homeMenuEntries
                .map(
                  (item) => ListTile(
                    title: Text(item.title),
                    leading: item.icon,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, item.route),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
