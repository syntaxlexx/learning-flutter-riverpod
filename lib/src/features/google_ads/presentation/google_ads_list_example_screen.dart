import 'package:flutter/material.dart';

import '../data/models/country.dart';
import 'admob_adaptive_ad.dart';

/// This example demonstrates inline ads in a list view, where the ad objects
/// live for the lifetime of this widget.
class GoogleAdsListExampleScreen extends StatelessWidget {
  const GoogleAdsListExampleScreen({super.key});
  static const route = '/google-ads-list-example';

  @override
  Widget build(BuildContext context) {
    return ListPage(
      countries: List.generate(
        50,
        (index) => const Country(name: 'Jamaica', code: '+420'),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.countries});

  final List<Country> countries;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Ads list Example'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          if (index > 0 && index % 3 == 0) {
            return const AdmobAdaptiveAd();
          }
          return const Divider();
        },
        itemBuilder: (context, index) {
          final country = widget.countries[index];

          return ListTile(
            title: Text(country.name),
            trailing: Text(country.code),
          );
        },
        itemCount: widget.countries.length,
      ),
    );
  }
}
