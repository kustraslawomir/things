import 'package:flutter/cupertino.dart';

import 'bloc/activity_data_state.dart';

abstract class ActivityDataPresenter {
  Future<void> loadThings(BuildContext context);

  Stream<ActivityDataState> thingsSateStream();

  void close();
}
