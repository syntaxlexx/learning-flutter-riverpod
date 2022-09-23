import 'package:flutter/material.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Tests'),
      ),
      body: ListView.builder(
        itemCount: HomeScreenController().entries.length,
        itemBuilder: (context, index) {
          final item = HomeScreenController().entries[index];

          return ListTile(
            title: Text(item.title),
            leading: item.icon,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, item.route),
          );
        },
      ),
    );
  }
}