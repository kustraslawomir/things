import 'package:things/ui/activities/item/bloc/activity_item_cubit.dart';
import 'package:things/ui/activities/item/bloc/activity_item_state.dart';

import 'activity_item_presenter.dart';

class ActivityItemPresenterImpl extends ActivityItemPresenter {
  final _activityItemCubit = ActivityItemCubit();

  @override
  void expandItemDescription() {
    _activityItemCubit.changeState(ActivityItemDescriptionExpanded());
  }

  @override
  Stream<ActivityItemState> activityItemStateStream() =>
      _activityItemCubit.stream;
}
