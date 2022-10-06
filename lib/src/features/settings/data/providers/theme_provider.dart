import 'package:enum_to_string/enum_to_string.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../utils/contants.dart';
import '../models/theme_scheme.dart';
import '../models/theme_state.dart';

final themeProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeState>((ref) {
  final box = Hive.box(Constants.settingsStorageKey);
  var themeState = ThemeState.initial();

  // scheme mode
  final scheme = box.get('scheme');
  if (scheme != null && scheme != 'default') {
    final decodedScheme =
        EnumToString.fromString(FlexScheme.values, scheme.toString());

    if (decodedScheme != null) {
      themeState = themeState.copyWith(
        scheme: decodedScheme,
      );
    }
  }

  // dark theme mode
  final isDarkModeOn = box.get('darkMode');

  if (isDarkModeOn != null && isDarkModeOn.toString() == 'yes') {
    return ThemeStateNotifier(
      themeState.copyWith(isDarkMode: true, mode: ThemeMode.dark),
    );
  }

  return ThemeStateNotifier(
    themeState.copyWith(isDarkMode: false, mode: ThemeMode.system),
  );
});

class ThemeStateNotifier extends StateNotifier<ThemeState> {
  ThemeStateNotifier(super.state);

  void toggle() {
    bool isDarkMode = state.isDarkMode;

    state = state.copyWith(
      mode: isDarkMode ? ThemeMode.light : ThemeMode.dark,
      isDarkMode: !isDarkMode,
    );

    updateStorage(!isDarkMode);
  }

  void setMode(bool isDarkMode) {
    state = state.copyWith(
      mode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      isDarkMode: isDarkMode,
    );

    updateStorage(isDarkMode);
  }

  void setScheme(FlexScheme scheme) {
    state = state.copyWith(
      scheme: scheme,
    );

    final box = Hive.box(Constants.settingsStorageKey);
    box.put('scheme', EnumToString.convertToString(scheme));
  }

  void updateStorage([bool isDarkModeOn = false]) {
    final box = Hive.box(Constants.settingsStorageKey);
    isDarkModeOn ? box.put('darkMode', 'yes') : box.delete('darkMode');
  }
}

final schemesProvider = StateProvider<List<ThemeScheme>>((ref) => [
      const ThemeScheme(
        name: 'Deep Purple',
        scheme: FlexScheme.deepPurple,
        color: Color(0xff4A2EA3),
      ),
      const ThemeScheme(
        name: 'Aqua Blue',
        scheme: FlexScheme.aquaBlue,
        color: Color(0xff3BA3CD),
      ),
      const ThemeScheme(
        name: 'Amber',
        scheme: FlexScheme.amber,
        color: Color(0xffE65706),
      ),
      const ThemeScheme(
        name: 'Big Stone',
        scheme: FlexScheme.bigStone,
        color: Color(0xff223348),
      ),
      const ThemeScheme(
        name: 'Mallard',
        scheme: FlexScheme.mallardGreen,
        color: Color(0xff344A27),
      ),
      const ThemeScheme(
        name: 'Wasabi',
        scheme: FlexScheme.wasabi,
        color: Color(0xff77892B),
      ),
      const ThemeScheme(
        name: 'Red Wine',
        scheme: FlexScheme.redWine,
        color: Color(0xff9E2237),
      ),
      const ThemeScheme(
        name: 'Material',
        scheme: FlexScheme.material,
        color: Color(0xff6709EF),
      ),
    ]);
