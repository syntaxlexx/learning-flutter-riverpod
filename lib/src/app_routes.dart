import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'features/calculator/presentation/calculator_screen.dart';
import 'features/counter/presentation/counter_screen.dart';
import 'features/counter/presentation/timer_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/movies/presentation/movies_paginated_screen.dart';
import 'features/movies/presentation/movies_screen.dart';
import 'features/network_status/presentation/network_status_screen.dart';
import 'features/providers/presentation/providers_screen.dart';
import 'features/stopwatch/presentation/stopwatch_screen.dart';
import 'features/trivia/presentation/trivia_screen.dart';
import 'features/websockets/presentation/websockets_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  HomeScreen.route: (context) => const HomeScreen(),
  ProvidersScreen.route: (context) => const ProvidersScreen(),
  CalculatorScreen.route: (context) => const CalculatorScreen(),
  NetworkStatusScreen.route: (context) => const NetworkStatusScreen(),
  StopwatchScreen.route: (context) => const StopwatchScreen(),
  TriviaScreen.route: (context) => const TriviaScreen(),
  WebsocketsScreen.route: (context) => const WebsocketsScreen(),
  MoviesScreen.route: (context) => const MoviesScreen(),
  MoviesPaginatedScreen.route: (context) => const MoviesPaginatedScreen(),
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
