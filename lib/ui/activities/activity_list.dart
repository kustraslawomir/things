import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:things/ui/activities/widgets/vertical_fade_out_widget.dart';

import '../../bloc/things_state.dart';
import '../../data/activity.dart';
import '../theme/dimensions.dart';
import '../utils/scroll/custom_scroll_physics.dart';
import 'activity_presenter.dart';
import 'item/activity_list_item_widget.dart';
import 'item/highlight_item_settings.dart';

class OffsetRange {
  final int end;

  OffsetRange(this.end);
}

class ActivityListWidget extends StatefulWidget {
  const ActivityListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ActivityListWidgetState();
  }
}

class _ActivityListWidgetState extends State<ActivityListWidget> {
  final ThingsPresenter _presenter = ThingsPresenterImpl();
  final ItemScrollController _controller = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  final Map<int, GlobalKey> _itemKeys = {};
  int _highlightedItemIndex = 0;
  bool _shouldExpandHighlightedItem = true;
  OffsetRange? _initialOffsetRange;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onItemPositionChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presenter.loadThings(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.screenPadding),
        child: StreamBuilder<ThingsState>(
            stream: _presenter.thingsSateStream(),
            builder:
                (BuildContext context, AsyncSnapshot<ThingsState> snapshot) {
              switch (snapshot.requireData.runtimeType) {
                case ThingsLoadedState:
                  {
                    List<Activity> activities =
                        (snapshot.requireData as ThingsLoadedState)
                                .things
                                .activities ??
                            <Activity>[];

                    return VerticalFadeOutWidget(
                        child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              _handleOnScrollNotification(scrollNotification);
                              return true;
                            },
                            child: _activityListWidget(activities, context)));
                  }
                case InitialState:
                  return const CircularProgressIndicator();
                default:
                  return const CircularProgressIndicator();
              }
            }));
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onItemPositionChange);
    _presenter.dispose();
    super.dispose();
  }

  void _handleOnScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollStartNotification) {
      _onScrollStarted(scrollNotification.metrics);
    } else if (scrollNotification is ScrollEndNotification) {
      _onScrollEnded(scrollNotification.metrics);
    }
  }

  _activityListWidget(List<Activity> activities, BuildContext context) {
    return ScrollablePositionedList.builder(
        itemCount: activities.length,
        itemScrollController: _controller,
        scrollOffsetListener: scrollOffsetListener,
        itemPositionsListener: _itemPositionsListener,
        itemBuilder: (BuildContext context, int index) {
          _itemKeys[index] = GlobalKey();
          return ActivityListItemWidget(
              key: _itemKeys[index],
              activity: activities[index],
              isHighlighted: index == _highlightedItemIndex,
              expandHighlightedItem: _shouldExpandHighlightedItem);
        },
        physics: const CustomScrollPhysics(
            scrollSpeedFactor: HighlightItemSettings.scrollSpeedFactor),
        padding: EdgeInsets.only(
            top: HighlightItemSettings.topPadding(context),
            bottom: HighlightItemSettings.bottomPadding(context)));
  }

  _onItemPositionChange() {
    if (_shouldExpandHighlightedItem) {
      return;
    }

    List visibleItems = _itemPositionsListener.itemPositions.value
        .where((element) =>
            (element.itemLeadingEdge < 1.0 && element.itemTrailingEdge > 0))
        .toList();
    visibleItems.sort((a, b) => a.index.compareTo(b.index));
    int firstVisibleItem = visibleItems.first.index;
    int lastVisibleItem = visibleItems.last.index;
    _initialOffsetRange ??= OffsetRange(lastVisibleItem);

    var initialOffsetRangeEnd = _initialOffsetRange?.end;
    if (initialOffsetRangeEnd == null) {
      return;
    }

    if (firstVisibleItem <= initialOffsetRangeEnd) {
      var currentHighlightItemIndex = lastVisibleItem - initialOffsetRangeEnd;
      if (currentHighlightItemIndex < 0) {
        _changeHighlightedIndex(0);
        return;
      }

      _changeHighlightedIndex(currentHighlightItemIndex);
      return;
    }

    var currentHighlightItemIndex = firstVisibleItem + initialOffsetRangeEnd;
    if (currentHighlightItemIndex > lastVisibleItem) {
      _changeHighlightedIndex(lastVisibleItem);
      return;
    }

    _changeHighlightedIndex(currentHighlightItemIndex);
  }

  _onScrollStarted(ScrollMetrics metrics) {
    if (_shouldExpandHighlightedItem) {
      setState(() {
        _shouldExpandHighlightedItem = false;
      });
    }
  }

  _onScrollEnded(ScrollMetrics metrics) {
    if (!_shouldExpandHighlightedItem) {
      setState(() {
        _shouldExpandHighlightedItem = true;
      });
    }
  }

  _changeHighlightedIndex(int index) {
    if (index != _highlightedItemIndex) {
      setState(() {
        _highlightedItemIndex = index;
        debugPrint('highlight item index no: $index');
      });
    }
  }
}
