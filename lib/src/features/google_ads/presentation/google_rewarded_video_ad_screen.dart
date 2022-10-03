import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'mixins/google_rewarded_video_ads_mixin.dart';

class GoogleRewardedVideoAdScreen extends StatefulWidget {
  const GoogleRewardedVideoAdScreen({super.key});
  static const route = '/google-rewarded-video-ads';

  @override
  _GoogleRewardedVideoAdScreenState createState() =>
      _GoogleRewardedVideoAdScreenState();
}

class _GoogleRewardedVideoAdScreenState
    extends State<GoogleRewardedVideoAdScreen>
    with GoogleRewardedVideoAdsMixin {
  var logger = Logger();

  @override
  void onRewardedVideoAdShown() {
    logger.i('Handle Ad Shown');
  }

  @override
  void onRewardedVideoAdDismissed() {
    logger.i('Handle Ad Dismissed');
    displayNotification('Reward user the coins');
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
        title: const Text('Google Rewarded Video Ads'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rewardedAdHasLoaded
                ? const Text('Ad loaded')
                : const Text('Ad NOT loaded'),
            ElevatedButton(
              onPressed: () {
                if (rewardedAd == null) {
                  displayNotification('Reward video not loaded yet');
                } else {
                  showRewardedAd();
                }
              },
              child: const Text('Show Rewarded Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
