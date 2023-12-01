import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_item_state.dart';

class ActivityItemCubit extends Cubit<ActivityItemState> {
  ActivityItemCubit() : super(ActivityItemDescriptionCollapsed());

  void changeState(ActivityItemState state) {
    debugPrint('change activity item cubit state to: $state');
    emit(state);
  }
}
