import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/ad_units.dart';

class AdmobAnchoredAd extends StatefulWidget {
  const AdmobAnchoredAd({Key? key}) : super(key: key);

  @override
  _AdmobAnchoredAdState createState() => _AdmobAnchoredAdState();
}

class _AdmobAnchoredAdState extends State<AdmobAnchoredAd> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }

  /// Load another ad, disposing of the current ad if there is one.
  Future<void> _loadAd() async {
    await _anchoredAdaptiveAd?.dispose();
    setState(() {
      _anchoredAdaptiveAd = null;
      _isLoaded = false;
    });

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid ? AdUnits.banner : AdUnits.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  /// Gets a widget containing the ad, if one is loaded.
  ///
  /// Returns an empty container if no ad is loaded, or the orientation
  /// has changed. Also loads a new ad if the orientation changes.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _anchoredAdaptiveAd != null &&
            _isLoaded) {
          return Container(
            color: Colors.green,
            width: _anchoredAdaptiveAd!.size.width.toDouble(),
            height: _anchoredAdaptiveAd!.size.height.toDouble(),
            child: AdWidget(ad: _anchoredAdaptiveAd!),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd();
        }
        return Container();
      },
    );
  }
}
