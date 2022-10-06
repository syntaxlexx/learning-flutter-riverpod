// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode mode;
  final FlexScheme scheme;
  final bool isDarkMode;

  ThemeState({
    required this.mode,
    required this.scheme,
    required this.isDarkMode,
  });

  factory ThemeState.initial() {
    return ThemeState(
      mode: ThemeMode.light,
      scheme: FlexScheme.dellGenoa,
      isDarkMode: false,
    );
  }

  ThemeState copyWith({
    ThemeMode? mode,
    FlexScheme? scheme,
    bool? isDarkMode,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      scheme: scheme ?? this.scheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
