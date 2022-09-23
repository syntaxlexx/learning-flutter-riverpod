import 'package:flutter/material.dart';
import 'features/counter/presentation/counter_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/providers/presentation/providers_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  HomeScreen.route: (context) => const HomeScreen(),
  CounterScreen.route: (context) => const CounterScreen(),
  ProvidersScreen.route: (context) => const ProvidersScreen(),
};
