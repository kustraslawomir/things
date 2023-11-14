import 'package:flutter/material.dart';
import 'package:things/ui/theme/text_size.dart';

import 'application_colors.dart';

class ApplicationThemeData {
  static var lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: ApplicationColors.seedColor),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white70,
      textTheme: _lightTextTheme);

  static var darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: ApplicationColors.seedColor),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black87,
      textTheme: _darkTextTheme);

  static const _lightTextTheme = TextTheme(
    bodySmall: TextStyle(
        color: ApplicationColors.lightTextColor, fontSize: TextSize.bodySmall),
    bodyMedium: TextStyle(
        color: ApplicationColors.lightTextColor, fontSize: TextSize.bodyMedium),
    bodyLarge: TextStyle(
        color: ApplicationColors.lightTextColor, fontSize: TextSize.bodyLarge),
    titleSmall: TextStyle(
        color: ApplicationColors.textTitleColor, fontSize: TextSize.titleSmall),
    titleMedium: TextStyle(
        color: ApplicationColors.textHighlightTitleColor,
        fontSize: TextSize.titleMedium),
    titleLarge: TextStyle(
        color: ApplicationColors.textTitleColor, fontSize: TextSize.titleLarge),
  );

  static const _darkTextTheme = TextTheme(
    bodySmall: TextStyle(
        color: ApplicationColors.darkTextColor, fontSize: TextSize.bodySmall),
    bodyMedium: TextStyle(
        color: ApplicationColors.darkTextColor, fontSize: TextSize.bodyMedium),
    bodyLarge: TextStyle(
        color: ApplicationColors.darkTextColor, fontSize: TextSize.bodyLarge),
    titleSmall: TextStyle(
        color: ApplicationColors.textTitleColor, fontSize: TextSize.titleSmall),
    titleMedium: TextStyle(
        color: ApplicationColors.textHighlightTitleColor,
        fontSize: TextSize.titleMedium),
    titleLarge: TextStyle(
        color: ApplicationColors.textTitleColor, fontSize: TextSize.titleLarge),
  );
}
