import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/ad_units.dart';

class AdmobAdaptiveAd extends StatefulWidget {
  const AdmobAdaptiveAd({super.key});

  @override
  _AdmobAdaptiveAdState createState() => _AdmobAdaptiveAdState();
}

class _AdmobAdaptiveAdState extends State<AdmobAdaptiveAd> {
  static const _adaptiveAdInsets = 16.0;
  AdManagerBannerAd? _inlineAdaptiveAd;
  bool _isAdaptiveAdLoaded = false;
  AdSize? _adaptiveAdSize;
  late Orientation _currentOrientation;

  double get _adaptiveAdWidth =>
      MediaQuery.of(context).size.width - (2 * _adaptiveAdInsets);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    loadAdaptiveAd();
  }

  void loadAdaptiveAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isAdaptiveAdLoaded = false;
    });

    // Get an inline adaptive size for the current orientation.
    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        _adaptiveAdWidth.truncate());

    _inlineAdaptiveAd = AdManagerBannerAd(
      adUnitId: AdUnits.banner,
      sizes: [size],
      request: const AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) async {
          print('Inline adaptive banner loaded: ${ad.responseInfo}');

          // After the ad is loaded, get the platform ad size and use it to
          // update the height of the container. This is necessary because the
          // height can change after the ad is loaded.
          AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isAdaptiveAdLoaded = true;
            _adaptiveAdSize = size;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _inlineAdaptiveAd != null &&
            _isAdaptiveAdLoaded &&
            _adaptiveAdSize != null) {
          return Align(
            child: SizedBox(
              width: _adaptiveAdWidth,
              height: _adaptiveAdSize!.height.toDouble(),
              child: AdWidget(
                ad: _inlineAdaptiveAd!,
              ),
            ),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          loadAdaptiveAd();
        }
        return Container();
      },
    );
  }
}
