import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/ad_units.dart';

abstract class GoogleInterstitialRewardedAdsActions {
  /// handle when an Ad is shown
  void onInterstitialRewardedAdShown();

  /// handle when an Ad is dismissed
  void onInterstitialRewardedAdDismissed();
}

mixin GoogleInterstitialRewardedAdsMixin<T extends StatefulWidget> on State<T>
    implements GoogleInterstitialRewardedAdsActions {
  RewardedInterstitialAd? rewardedInterstitialAd;
  int numRewardedInterstitialLoadAttempts = 0;
  bool interstitialRewardedAdHasLoaded = false;

  @override
  void initState() {
    super.initState();
    createRewardedInterstitialAd();
  }

  void createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? AdUnits.rewardedInterstitial
            : AdUnits.rewardedInterstitial,
        request: AdUnits.request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            print('$ad loaded.');
            rewardedInterstitialAd = ad;
            setState(() {
              interstitialRewardedAdHasLoaded = true;
            });
            numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (error) {
            print('RewardedInterstitialAd failed to load: $error');
            rewardedInterstitialAd = null;
            setState(() {
              interstitialRewardedAdHasLoaded = false;
            });
            numRewardedInterstitialLoadAttempts += 1;
            if (numRewardedInterstitialLoadAttempts <
                AdUnits.maxFailedLoadAttempts) {
              createRewardedInterstitialAd();
            }
          },
        ));
  }

  void showRewardedInterstitialAd() {
    if (rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('$ad onAdShowedFullScreenContent.');
        onInterstitialRewardedAdShown();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent.');
        onInterstitialRewardedAdDismissed();
        ad.dispose();
        createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        createRewardedInterstitialAd();
        ad.dispose();
      },
    );

    rewardedInterstitialAd!.setImmersiveMode(true);
    rewardedInterstitialAd!.show(onUserEarnedReward: (ad, reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedInterstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    rewardedInterstitialAd?.dispose();
  }
}
