import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/ad_units.dart';

abstract class GoogleInterstitialAdsActions {
  /// handle when an Ad is shown
  void onInterstitialAdShown();

  /// handle when an Ad is dismissed
  void onInterstitialAdDismissed();
}

mixin GoogleInterstitialAdsMixin<T extends StatefulWidget> on State<T>
    implements GoogleInterstitialAdsActions {
  InterstitialAd? interstitialAd;
  int numInterstitialLoadAttempts = 0;
  bool interstitialAdHasLoaded = false;

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId:
          Platform.isAndroid ? AdUnits.interstitial : AdUnits.interstitial,
      request: AdUnits.request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded');
          interstitialAd = ad;
          numInterstitialLoadAttempts = 0;
          setState(() {
            interstitialAdHasLoaded = true;
          });
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error.');
          numInterstitialLoadAttempts += 1;
          setState(() {
            interstitialAdHasLoaded = false;
          });
          interstitialAd = null;
          if (numInterstitialLoadAttempts < AdUnits.maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        onInterstitialAdShown();
        print('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent.');
        onInterstitialAdDismissed();
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
  }
}

mixin GoogleInterstitialAdsRiverpodMixin<T extends ConsumerStatefulWidget>
    on State<T> implements GoogleInterstitialAdsActions {
  InterstitialAd? interstitialAd;
  int numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId:
          Platform.isAndroid ? AdUnits.interstitial : AdUnits.interstitial,
      request: AdUnits.request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded');
          interstitialAd = ad;
          numInterstitialLoadAttempts = 0;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error.');
          numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (numInterstitialLoadAttempts < AdUnits.maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        onInterstitialAdShown();
        print('ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
        onInterstitialAdDismissed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
  }
}

// class GoogleInterstitialAds {
  
// }
