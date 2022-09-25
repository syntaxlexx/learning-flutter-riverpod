import 'package:flutter/material.dart';
import '../../../common_widgets/connectivity_warning.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Riverpod Mobbin Zone'),
      ),
      body: ListView(
        children: [
          const ConnectivityWarning(),
          Column(
            children: HomeScreenController()
                .entries
                .map((item) => ListTile(
                      title: Text(item.title),
                      leading: item.icon,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(context, item.route),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
