import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../data/activity.dart';
import '../../theme/dimensions.dart';
import 'highlight_item_settings.dart';

class ActivityListItemWidget extends StatefulWidget {
  final Activity activity;
  final bool isHighlighted;
  final bool expandHighlightedItem;

  const ActivityListItemWidget(
      {super.key,
      required this.activity,
      required this.isHighlighted,
      required this.expandHighlightedItem});

  @override
  State<StatefulWidget> createState() {
    return _ActivityListItemState();
  }
}

class _ActivityListItemState extends State<ActivityListItemWidget> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.isHighlighted && widget.expandHighlightedItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startFadeIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical : Dimensions.listItemVerticalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          AutoSizeText(widget.activity.title ?? "",
              maxLines: 1,
              style: widget.isHighlighted
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleSmall),
          if (widget.isHighlighted && widget.expandHighlightedItem)
            AnimatedOpacity(
                opacity: _opacity,
                duration: HighlightItemSettings.fadeInDescriptionDuration,
                // Duration of the fade
                child: Text(widget.activity.getDescriptionWithHashTags() ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.end))
        ]));
  }

  void _startFadeIn() {
    setState(() {
      _opacity = 1.0;
    });
  }
}