import 'package:flutter/cupertino.dart';

import 'model/activity_data_model.dart';

abstract class ActivityDataLocalRepository {
  Future<ActivityData> loadData(BuildContext context);
}
