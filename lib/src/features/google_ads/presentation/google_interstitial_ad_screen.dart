import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'mixins/google_interstitial_ads_mixin.dart';

class GoogleInterstitialAdScreen extends StatefulWidget {
  const GoogleInterstitialAdScreen({super.key});
  static const route = '/google-interstitial-ads';

  @override
  _GoogleInterstitialAdScreenState createState() =>
      _GoogleInterstitialAdScreenState();
}

class _GoogleInterstitialAdScreenState extends State<GoogleInterstitialAdScreen>
    with GoogleInterstitialAdsMixin {
  var logger = Logger();

  @override
  void onInterstitialAdShown() {
    logger.i('Handle Ad Shown');
  }

  @override
  void onInterstitialAdDismissed() {
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
        title: const Text('Google Interstitial Ads'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            interstitialAdHasLoaded
                ? const Text('Ad loaded')
                : const Text('Ad NOT loaded'),
            ElevatedButton(
              onPressed: () {
                if (interstitialAd == null) {
                  displayNotification('Interstitial Ad not loaded yet');
                } else {
                  showInterstitialAd();
                }
              },
              child: const Text('Show Interstitial Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
