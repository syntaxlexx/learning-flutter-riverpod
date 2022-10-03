import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdUnits {
  static String testDevice = '';
  static const int maxFailedLoadAttempts = 3;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    // contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  static String get banner => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static String get interstitial => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/1033173712';

  static String get interstitialVideo => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/8691691433'
      : 'ca-app-pub-3940256099942544/8691691433';

  static String get rewarded => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/5224354917';

  static String get rewardedInterstitial => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/5354046379';

  static String get nativeAdvanced => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/2247696110';

  static String get nativeAdvancedVideo => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1044960115'
      : 'ca-app-pub-3940256099942544/1044960115';

  static String get appOpen => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/3419835294'
      : 'ca-app-pub-3940256099942544/3419835294';
}
