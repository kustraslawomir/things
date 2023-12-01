import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../data/local/model/activity.dart';
import '../../theme/dimensions.dart';
import 'activity_item_presenter_impl.dart';
import 'activity_item_presenter.dart';
import 'bloc/activity_item_state.dart';
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
  final ActivityItemPresenter _presenter = ActivityItemPresenterImpl();

  @override
  void initState() {
    super.initState();
    if (_isItemSelected()) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _presenter.expandItemDescription());
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

  @override
  void dispose() {
    super.dispose();
  }

  AutoSizeText _buildItemTitle(BuildContext context) {
    return AutoSizeText(widget.activity.title ?? "",
        maxLines: 1,
        style: widget.isHighlighted
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.titleSmall);
  }

  Widget _buildItemDescription(BuildContext context) {
    return StreamBuilder(
        stream: _presenter.activityItemStateStream(),
        builder:
            (BuildContext context, AsyncSnapshot<ActivityItemState> snapshot) {
          var descriptionOpacity = 0.0;

          if (snapshot.hasData) {
            switch (snapshot.requireData.runtimeType) {
              case ActivityItemDescriptionCollapsed:
                descriptionOpacity = 0.0;
                break;
              case ActivityItemDescriptionExpanded:
                descriptionOpacity = 1.0;
                break;
            }
          }
          return AnimatedOpacity(
              opacity: descriptionOpacity,
              duration: HighlightItemSettings.fadeInDescriptionDuration,
              child: Text(widget.activity.getDescriptionWithHashTags(),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end));
        });
  }

  bool _isItemSelected() =>
      widget.isHighlighted && widget.expandHighlightedItem;
}
