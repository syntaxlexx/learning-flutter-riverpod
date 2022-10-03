import 'package:flutter/material.dart';

import 'admob_adaptive_ad.dart';

class GoogleInlineAdsScreen extends StatelessWidget {
  const GoogleInlineAdsScreen({super.key});
  static const route = '/google-inline-ads';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Googl Inline Adaptive Ad'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('Lorem Ipsum whatever is Lorem'),
              ),
            ),
            AdmobAdaptiveAd(),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('Lorem Ipsum whatever is Lorem 2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
