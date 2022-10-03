import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/ad_units.dart';

class GoogleAdsAdvancedListExampleScreen extends StatefulWidget {
  const GoogleAdsAdvancedListExampleScreen({Key? key}) : super(key: key);
  static const route = '/google-ads-advanced-list-example';

  @override
  _GoogleAdsAdvancedListExampleScreenState createState() =>
      _GoogleAdsAdvancedListExampleScreenState();
}

class _GoogleAdsAdvancedListExampleScreenState
    extends State<GoogleAdsAdvancedListExampleScreen> {
  BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;

  AdManagerBannerAd? _adManagerBannerAd;
  bool _adManagerBannerAdIsLoaded = false;

  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Ads Advanced List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: 20,
          separatorBuilder: (context, index) {
            return Container(
              height: 40,
            );
          },
          itemBuilder: (context, index) {
            final BannerAd? bannerAd = _bannerAd;
            if (index == 5 && _bannerAdIsLoaded && bannerAd != null) {
              return SizedBox(
                height: bannerAd.size.height.toDouble(),
                width: bannerAd.size.width.toDouble(),
                child: AdWidget(ad: bannerAd),
              );
            }

            final AdManagerBannerAd? adManagerBannerAd = _adManagerBannerAd;
            if (index == 10 &&
                _adManagerBannerAdIsLoaded &&
                adManagerBannerAd != null) {
              return SizedBox(
                height: adManagerBannerAd.sizes[0].height.toDouble(),
                width: adManagerBannerAd.sizes[0].width.toDouble(),
                child: AdWidget(ad: _adManagerBannerAd!),
              );
            }

            final NativeAd? nativeAd = _nativeAd;
            if (index == 15 && _nativeAdIsLoaded && nativeAd != null) {
              return SizedBox(
                  width: 250, height: 350, child: AdWidget(ad: nativeAd));
            }

            return const Text(
              'Lorem ipsum hwfwefg ajhskfb aejsfvkhejasf vjakgf ewf',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? AdUnits.banner : AdUnits.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            print('$BannerAd loaded.');
            setState(() {
              _bannerAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            print('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (ad) => print('$BannerAd onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();

    _nativeAd = NativeAd(
      adUnitId:
          Platform.isAndroid ? AdUnits.nativeAdvanced : AdUnits.nativeAdvanced,
      request: const AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (ad) => print('$NativeAd onAdClosed.'),
      ),
    )..load();

    _adManagerBannerAd = AdManagerBannerAd(
      adUnitId: AdUnits.banner,
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      sizes: <AdSize>[AdSize.largeBanner],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          print('$AdManagerBannerAd loaded.');
          setState(() {
            _adManagerBannerAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('$AdManagerBannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (ad) => print('$AdManagerBannerAd onAdOpened.'),
        onAdClosed: (ad) => print('$AdManagerBannerAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _adManagerBannerAd?.dispose();
    _nativeAd?.dispose();
  }
}
