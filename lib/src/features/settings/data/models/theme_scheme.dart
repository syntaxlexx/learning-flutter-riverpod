import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeScheme {
  final String name;
  final FlexScheme scheme;
  final Color color;

  const ThemeScheme({
    required this.name,
    required this.scheme,
    required this.color,
  });
}
