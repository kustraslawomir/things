import 'package:flutter/cupertino.dart';

class HighlightItemSettings {
  static const double scrollSpeedFactor = 0.3;

  static double topPadding(BuildContext context) {
    return MediaQuery.of(context).size.height / 2;
  }

  static double bottomPadding(BuildContext context) {
    return MediaQuery.of(context).size.height / 1.4;
  }

  static const fadeInDescriptionDuration = Duration(milliseconds: 900);
}
