import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'common_widgets/error_screen.dart';
import 'features/auth/ui/auth_screen.dart';
import 'features/auth/ui/dashboard_screen.dart';
import 'features/calculator/ui/calculator_screen.dart';
import 'features/counter/ui/counter_screen.dart';
import 'features/counter/ui/timer_screen.dart';
import 'features/home/ui/home_screen.dart';
import 'features/movies/ui/movies_paginated_screen.dart';
import 'features/movies/ui/movies_screen.dart';
import 'features/network_status/ui/network_status_screen.dart';
import 'features/products/ui/products_screen.dart';
import 'features/providers/ui/providers_screen.dart';
import 'features/settings/ui/settings_screen.dart';
import 'features/stopwatch/ui/stopwatch_screen.dart';
import 'features/trivia/ui/trivia_screen.dart';
import 'features/websockets/ui/websockets_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  HomeScreen.route: (context) => const HomeScreen(),
  ErrorScreen.route: (context) => ErrorScreen(),
  ProvidersScreen.route: (context) => const ProvidersScreen(),
  CalculatorScreen.route: (context) => const CalculatorScreen(),
  NetworkStatusScreen.route: (context) => const NetworkStatusScreen(),
  StopwatchScreen.route: (context) => const StopwatchScreen(),
  TriviaScreen.route: (context) => const TriviaScreen(),
  WebsocketsScreen.route: (context) => const WebsocketsScreen(),
  MoviesScreen.route: (context) => const MoviesScreen(),
  MoviesPaginatedScreen.route: (context) => const MoviesPaginatedScreen(),
  ProductsScreen.route: (context) => ProductsScreen(),
  SettingsScreen.route: (context) => const SettingsScreen(),
  AuthScreen.route: (context) => const AuthScreen(),
  DashboardScreen.route: (context) => const DashboardScreen(),
};

Route<dynamic>? appGeneratedRoutes(RouteSettings settings) {
  switch (settings.name) {
    case CounterScreen.route:
      return PageTransition(
          child: const CounterScreen(), type: PageTransitionType.bottomToTop);
    case TimerScreen.route:
      return PageTransition(
          child: const TimerScreen(), type: PageTransitionType.bottomToTop);
    default:
      break;
  }

  return null;
}
