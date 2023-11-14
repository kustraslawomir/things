
import 'package:flutter/material.dart';

extension GetColorScheme on BuildContext {
  ColorScheme scheme() {
    return Theme.of(this).colorScheme;
  }
}