import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:things/data/local/model/activity_data_model.dart';
import 'package:things/gen/assets.gen.dart';

import 'activity_data_local_repository.dart';

class ActivityDataLocalRepositoryImpl extends ActivityDataLocalRepository {
  @override
  Future<ActivityData> loadData(BuildContext context) async {
    String jsonData = await rootBundle.loadString(Assets.json.activities);
    Map<String, dynamic> jsonMap = await json.decode(jsonData);
    return ActivityData.fromJson(jsonMap);
  }
}
