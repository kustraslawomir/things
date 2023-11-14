import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final bool isExpanded;

  const ExpandableText(
      {super.key, required this.text, required this.isExpanded});

  @override
  State<StatefulWidget> createState() {
    return ExpandableTextState();
  }
}

class ExpandableTextState extends State<ExpandableText> {
  var isExpanded = false;
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (widget.isExpanded) {
        setState(() {
          isExpanded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(seconds: 2), // Duration of the fade
      child: Text(
        widget.text,
        softWrap: true,
        overflow: TextOverflow.fade,
      ),
    );
  }

  void _startFadeIn() {
    setState(() {
      opacity = 1.0; // Fully opaque
    });
  }
}
