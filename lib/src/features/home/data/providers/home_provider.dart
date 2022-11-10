import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../auth/ui/auth_screen.dart';
import '../../../calculator/ui/calculator_screen.dart';
import '../../../counter/ui/counter_screen.dart';

import '../../../counter/ui/timer_screen.dart';
import '../../../movies/ui/movies_paginated_screen.dart';
import '../../../movies/ui/movies_screen.dart';
import '../../../network_status/ui/network_status_screen.dart';
import '../../../products/ui/products_screen.dart';
import '../../../providers/ui/providers_screen.dart';
import '../../../settings/ui/settings_screen.dart';
import '../../../stopwatch/ui/stopwatch_screen.dart';
import '../../../trivia/ui/trivia_screen.dart';
import '../../../websockets/ui/websockets_screen.dart';
import '../models/entry.dart';

final homeMenuEntriesProvider = StateProvider<List<Entry>>((ref) {
  return [
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
    Entry(
      title: 'Websockets',
      icon: const Icon(Icons.wifi_tethering),
      route: WebsocketsScreen.route,
    ),
    Entry(
      title: 'Movies',
      icon: const Icon(Icons.movie),
      route: MoviesScreen.route,
    ),
    Entry(
      title: 'Movies (Paginated)',
      icon: const Icon(Icons.list),
      route: MoviesPaginatedScreen.route,
    ),
    Entry(
      title: 'Products (Pagination via StateNotifier)',
      icon: const Icon(Icons.shopping_cart),
      route: ProductsScreen.route,
    ),
    Entry(
      title: 'Settings',
      icon: const Icon(Icons.settings),
      route: SettingsScreen.route,
    ),
    Entry(
      title: 'Auth',
      icon: const Icon(Icons.home),
      route: AuthScreen.route,
    ),
  ];
});
