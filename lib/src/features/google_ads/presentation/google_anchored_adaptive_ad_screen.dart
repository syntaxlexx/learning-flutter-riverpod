import 'package:flutter/material.dart';

import 'admob_anchored_ad.dart';

class GoogleAnchoredAdaptiveAdScreen extends StatelessWidget {
  const GoogleAnchoredAdaptiveAdScreen({super.key});
  static const route = '/google-anchored-adaptive-ads';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Anchored Adaptive'),
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
            AdmobAnchoredAd(),
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
