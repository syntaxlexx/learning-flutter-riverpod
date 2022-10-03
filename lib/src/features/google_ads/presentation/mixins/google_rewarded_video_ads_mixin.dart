import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../data/ad_units.dart';

abstract class GoogleRewardedVideAdsActions {
  /// handle when an Ad is shown
  void onRewardedVideoAdShown();

  /// handle when an Ad is dismissed
  void onRewardedVideoAdDismissed();
}

mixin GoogleRewardedVideoAdsMixin<T extends StatefulWidget> on State<T>
    implements GoogleRewardedVideAdsActions {
  RewardedAd? rewardedAd;
  bool rewardedAdHasLoaded = false;
  int _numRewardedLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    createRewardedAd();
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid ? AdUnits.rewarded : AdUnits.rewarded,
        request: AdUnits.request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            print('$ad loaded.');
            rewardedAd = ad;
            setState(() {
              rewardedAdHasLoaded = true;
            });
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (error) {
            print('RewardedAd failed to load: $error');
            rewardedAd = null;
            setState(() {
              rewardedAdHasLoaded = false;
            });
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < AdUnits.maxFailedLoadAttempts) {
              createRewardedAd();
            }
          },
        ));
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('ad onAdShowedFullScreenContent.');
        onRewardedVideoAdShown();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent.');
        onRewardedVideoAdDismissed();
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
  }
}
