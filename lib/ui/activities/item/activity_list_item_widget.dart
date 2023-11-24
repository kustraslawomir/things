import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../data/local/model/activity.dart';
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
  double _descriptionItemOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    if (_isItemSelected()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startFadeIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.listItemVerticalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          _buildItemTitle(context),
          if (_isItemSelected()) _buildItemDescription(context)
        ]));
  }

  AutoSizeText _buildItemTitle(BuildContext context) {
    return AutoSizeText(widget.activity.title ?? "",
        maxLines: 1,
        style: widget.isHighlighted
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.titleSmall);
  }

  AnimatedOpacity _buildItemDescription(BuildContext context) {
    return AnimatedOpacity(
        opacity: _descriptionItemOpacity,
        duration: HighlightItemSettings.fadeInDescriptionDuration,
        child: Text(widget.activity.getDescriptionWithHashTags(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.end));
  }

  bool _isItemSelected() =>
      widget.isHighlighted && widget.expandHighlightedItem;

  _startFadeIn() {
    if(!mounted){
      return;
    }

    setState(() {
      _descriptionItemOpacity = 1.0;
    });
  }
}
