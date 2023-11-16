import 'package:flutter/material.dart';
import 'package:things/ui/utils/extensions/theme_extensions.dart';

class VerticalFadeOutWidget extends StatelessWidget {

  final Widget child;

  const VerticalFadeOutWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(shaderCallback: (rect) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          context.scheme().background,
          context.scheme().background,
          context.scheme().background,
          Colors.transparent
        ],
      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
    }, child: child);
  }
}
