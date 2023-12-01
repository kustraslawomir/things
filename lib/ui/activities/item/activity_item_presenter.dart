import 'bloc/activity_item_state.dart';

abstract class ActivityItemPresenter {

  Stream<ActivityItemState> activityItemStateStream();

  void expandItemDescription();

}
