import 'package:flutter/material.dart';
import '../../calculator/presentation/calculator_screen.dart';
import '../../counter/presentation/counter_screen.dart';

import '../../counter/presentation/timer_screen.dart';
import '../../network_status/presentation/network_status_screen.dart';
import '../../providers/presentation/providers_screen.dart';
import '../../stopwatch/presentation/stopwatch_screen.dart';
import '../../trivia/presentation/trivia_screen.dart';
import '../domain/models/entry.dart';

class HomeScreenController {
  final List<Entry> _entries = [
    Entry(
      title: 'Providers',
      icon: const Icon(Icons.shopping_cart),
      route: ProvidersScreen.route,
    ),
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
      title: 'Calculator',
      icon: const Icon(Icons.calculate),
      route: CalculatorScreen.route,
    ),
    Entry(
      title: 'Network Status',
      icon: const Icon(Icons.network_check),
      route: NetworkStatusScreen.route,
    ),
    Entry(
      title: 'Stopwatch',
      icon: const Icon(Icons.timelapse_rounded),
      route: StopwatchScreen.route,
    ),
    Entry(
      title: 'Trivia',
      icon: const Icon(Icons.question_answer),
      route: TriviaScreen.route,
    ),
  ];

  List<Entry> get entries => _entries;
}

// final homeScreenProvider = StateProvider.autoDispose((ref) => Counter());
