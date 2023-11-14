import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

                    return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollStartNotification) {
                            _onStartScroll(scrollNotification.metrics);
                          } else if (scrollNotification
                              is ScrollEndNotification) {
                            _onEndScroll(scrollNotification.metrics);
                          }
                          return true;
                        },
                        child: ScrollablePositionedList.builder(
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
                                  expandHighlightedItem:
                                      _shouldExpandHighlightedItem);
                            },
                            physics: const CustomScrollPhysics(
                                scrollSpeedFactor:
                                    HighlightItemSettings.scrollSpeedFactor),
                            padding: EdgeInsets.only(
                                top: HighlightItemSettings.topPadding(context),
                                bottom: HighlightItemSettings.bottomPadding(
                                    context))));
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

  void _onItemPositionChange() {
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

    debugPrint(
        "first: $firstVisibleItem last: $lastVisibleItem offset end: $initialOffsetRangeEnd");

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

  void _changeHighlightedIndex(int index) {
    if (index != _highlightedItemIndex) {
      setState(() {
        _highlightedItemIndex = index;
        debugPrint('[list] highlightItemIndex: $index');
      });
    }
  }

  _onStartScroll(ScrollMetrics metrics) {
    debugPrint("Scroll Start");
    if (_shouldExpandHighlightedItem) {
      setState(() {
        _shouldExpandHighlightedItem = false;
      });
    }
  }

  _onEndScroll(ScrollMetrics metrics) {
    debugPrint("Scroll End");
    if (!_shouldExpandHighlightedItem) {
      setState(() {
        _shouldExpandHighlightedItem = true;
      });
    }
  }
}
