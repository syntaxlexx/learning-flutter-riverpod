import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'mixins/google_interstitial_rewarded_ads_mixin.dart';

class GoogleInterstitialRewardedAdScreen extends StatefulWidget {
  const GoogleInterstitialRewardedAdScreen({super.key});
  static const route = '/google-interstitial-rewarded-ads';

  @override
  _GoogleInterstitialRewardedAdScreenState createState() =>
      _GoogleInterstitialRewardedAdScreenState();
}

class _GoogleInterstitialRewardedAdScreenState
    extends State<GoogleInterstitialRewardedAdScreen>
    with GoogleInterstitialRewardedAdsMixin {
  var logger = Logger();

  @override
  void onInterstitialRewardedAdShown() {
    logger.i('Handle Ad Shown');
  }

  @override
  void onInterstitialRewardedAdDismissed() {
    logger.i('Handle Ad Dismissed');
    displayNotification('Reward user');
  }

  void displayNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Interstitial Rewarded Ads'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            interstitialRewardedAdHasLoaded
                ? const Text('Ad loaded')
                : const Text('Ad NOT loaded'),
            ElevatedButton(
              onPressed: () {
                if (rewardedInterstitialAd == null) {
                  displayNotification('Interstitial Reward Ad not loaded yet');
                } else {
                  showRewardedInterstitialAd();
                }
              },
              child: const Text('Show Interstitial Rewarded Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
