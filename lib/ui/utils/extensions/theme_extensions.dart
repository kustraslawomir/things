import 'package:flutter/material.dart';

extension GetColorSchemeExtension on BuildContext {
  ColorScheme scheme() {
    return Theme.of(this).colorScheme;
  }
}