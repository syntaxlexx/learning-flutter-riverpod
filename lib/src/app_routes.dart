import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'features/counter/presentation/counter_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/providers/presentation/providers_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  HomeScreen.route: (context) => const HomeScreen(),
  ProvidersScreen.route: (context) => const ProvidersScreen(),
};

Route<dynamic>? appGeneratedRoutes(RouteSettings settings) {
  switch (settings.name) {
    case CounterScreen.route:
      return PageTransition(
          child: const CounterScreen(), type: PageTransitionType.bottomToTop);
    default:
      break;
  }

  return null;
}
