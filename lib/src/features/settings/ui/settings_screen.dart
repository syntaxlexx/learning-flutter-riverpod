import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const route = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkTheme = ref.watch(darkThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text('Dark Mode'),
                leading: darkTheme
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
                trailing: Switch(
                  value: darkTheme,
                  onChanged: (value) {
                    ref.read(darkThemeProvider.notifier).toggle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
