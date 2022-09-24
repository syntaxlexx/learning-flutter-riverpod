import 'package:flutter/material.dart';
import '../../counter/presentation/counter_screen.dart';

import '../../counter/presentation/timer_screen.dart';
import '../../providers/presentation/providers_screen.dart';
import '../domain/models/entry.dart';

class HomeScreenController {
  final List<Entry> _entries = [
    Entry(
      title: 'Counter App',
      icon: const Icon(Icons.timer),
      route: CounterScreen.route,
    ),
    Entry(
      title: 'Timer with Alert',
      icon: const Icon(Icons.timer_10_select),
      route: TimerScreen.route,
    ),
    Entry(
      title: 'Providers',
      icon: const Icon(Icons.gif),
      route: ProvidersScreen.route,
    ),
  ];

  List<Entry> get entries => _entries;
}

// final homeScreenProvider = StateProvider.autoDispose((ref) => Counter());
