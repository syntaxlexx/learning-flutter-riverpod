import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final darkThemeProvider = StateNotifierProvider<DarkStateNotifier, bool>((ref) {
  final box = Hive.box('settings');
  final isDarkModeOn = box.get('darkMode');
  return DarkStateNotifier(isDarkModeOn != null);
});

class DarkStateNotifier extends StateNotifier<bool> {
  DarkStateNotifier(super.state);

  void toggle() {
    state = !state;

    updateStorage(state);
  }

  void updateStorage([bool isDarkModeOn = false]) {
    final box = Hive.box('settings');
    isDarkModeOn ? box.put('darkMode', 'yes') : box.delete('darkMode');
  }
}
