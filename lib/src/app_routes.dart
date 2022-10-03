import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'features/calculator/presentation/calculator_screen.dart';
import 'features/counter/presentation/counter_screen.dart';
import 'features/counter/presentation/timer_screen.dart';
import 'features/google_ads/presentation/google_ads_advanced_list_example_screen.dart';
import 'features/google_ads/presentation/google_ads_list_example_screen.dart';
import 'features/google_ads/presentation/google_ads_screen.dart';
import 'features/google_ads/presentation/google_anchored_adaptive_ad_screen.dart';
import 'features/google_ads/presentation/google_inline_ads_screen.dart';
import 'features/google_ads/presentation/google_interstitial_ad_screen.dart';
import 'features/google_ads/presentation/google_interstitial_rewarded_ad_screen.dart';
import 'features/google_ads/presentation/google_rewarded_video_ad_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/network_status/presentation/network_status_screen.dart';
import 'features/providers/presentation/providers_screen.dart';
import 'features/stopwatch/presentation/stopwatch_screen.dart';
import 'features/trivia/presentation/trivia_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  HomeScreen.route: (context) => const HomeScreen(),
  ProvidersScreen.route: (context) => const ProvidersScreen(),
  CalculatorScreen.route: (context) => const CalculatorScreen(),
  NetworkStatusScreen.route: (context) => const NetworkStatusScreen(),
  StopwatchScreen.route: (context) => const StopwatchScreen(),
  TriviaScreen.route: (context) => const TriviaScreen(),
  GoogleAdsScreen.route: (context) => const GoogleAdsScreen(),
  GoogleInlineAdsScreen.route: (context) => const GoogleInlineAdsScreen(),
  GoogleAnchoredAdaptiveAdScreen.route: (context) =>
      const GoogleAnchoredAdaptiveAdScreen(),
  GoogleAdsListExampleScreen.route: (context) =>
      const GoogleAdsListExampleScreen(),
  GoogleAdsAdvancedListExampleScreen.route: (context) =>
      const GoogleAdsAdvancedListExampleScreen(),
  GoogleInterstitialAdScreen.route: (context) =>
      const GoogleInterstitialAdScreen(),
  GoogleInterstitialRewardedAdScreen.route: (context) =>
      const GoogleInterstitialRewardedAdScreen(),
  GoogleRewardedVideoAdScreen.route: (context) =>
      const GoogleRewardedVideoAdScreen(),
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
