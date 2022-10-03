import 'package:flutter/material.dart';

import 'google_ads_advanced_list_example_screen.dart';
import 'google_ads_list_example_screen.dart';
import 'google_anchored_adaptive_ad_screen.dart';
import 'google_inline_ads_screen.dart';
import 'google_interstitial_ad_screen.dart';
import 'google_interstitial_rewarded_ad_screen.dart';
import 'google_rewarded_video_ad_screen.dart';

class GoogleAdsScreen extends StatelessWidget {
  const GoogleAdsScreen({super.key});
  static const route = '/google-ads';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Ads'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, GoogleInlineAdsScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Inline Adaptive',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, GoogleAnchoredAdaptiveAdScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              child: const Center(
                child: Text(
                  'Anchored Adaptive',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, GoogleAdsListExampleScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              child: const Center(
                child: Text(
                  'List Example',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, GoogleAdsAdvancedListExampleScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Advanced List Example',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, GoogleInterstitialAdScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Interstitial Ad',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, GoogleInterstitialRewardedAdScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Interstitial Rewarded Ad',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, GoogleRewardedVideoAdScreen.route),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Rewarded Video Ad',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
