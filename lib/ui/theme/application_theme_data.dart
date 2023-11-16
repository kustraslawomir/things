import 'package:flutter/material.dart';
import 'package:things/ui/theme/text_size.dart';

import 'color_scheme.dart';

class ApplicationThemeData {
  static var lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColorScheme.seedColor),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColorScheme.lightBackground,
      textTheme: _lightTextTheme);

  static var darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColorScheme.seedColor),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColorScheme.darkBackground,
      textTheme: _darkTextTheme);

  static const _lightTextTheme = TextTheme(
    bodySmall: TextStyle(
        color: AppColorScheme.lightTextColor, fontSize: TextSize.bodySmall),
    bodyMedium: TextStyle(
        color: AppColorScheme.lightTextColor, fontSize: TextSize.bodyMedium),
    bodyLarge: TextStyle(
        color: AppColorScheme.lightTextColor, fontSize: TextSize.bodyLarge),
    titleSmall: TextStyle(
        color: AppColorScheme.lightTextTitleColor,
        fontSize: TextSize.titleSmall),
    titleMedium: TextStyle(
        color: AppColorScheme.highlightTextColor,
        fontSize: TextSize.titleMedium),
    titleLarge: TextStyle(
        color: AppColorScheme.lightTextTitleColor,
        fontSize: TextSize.titleLarge),
  );

  static const _darkTextTheme = TextTheme(
    bodySmall: TextStyle(
        color: AppColorScheme.darkTextColor, fontSize: TextSize.bodySmall),
    bodyMedium: TextStyle(
        color: AppColorScheme.darkTextColor, fontSize: TextSize.bodyMedium),
    bodyLarge: TextStyle(
        color: AppColorScheme.darkTextColor, fontSize: TextSize.bodyLarge),
    titleSmall: TextStyle(
        color: AppColorScheme.darkTextTitleColor,
        fontSize: TextSize.titleSmall),
    titleMedium: TextStyle(
        color: AppColorScheme.highlightTextColor,
        fontSize: TextSize.titleMedium),
    titleLarge: TextStyle(
        color: AppColorScheme.darkTextTitleColor,
        fontSize: TextSize.titleLarge),
  );
}
