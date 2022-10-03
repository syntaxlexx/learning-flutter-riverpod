import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkThemeProvider = StateNotifierProvider<DarkStateNotifier, bool>(
    (ref) => DarkStateNotifier(false));

class DarkStateNotifier extends StateNotifier<bool> {
  DarkStateNotifier(super.state);

  void toggle() {
    state = !state;
  }
}
