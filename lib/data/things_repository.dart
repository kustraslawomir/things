import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:things/data/things.dart';
import 'package:things/gen/assets.gen.dart';

abstract class ThingsRepository {
  Future<Things> loadThings(BuildContext context);
}

class ThingsRepositoryImpl extends ThingsRepository {
  @override
  Future<Things> loadThings(BuildContext context) async {
    String jsonData = await rootBundle.loadString(Assets.json.things);
    Map<String, dynamic> jsonMap = await json.decode(jsonData);
    return Things.fromJson(jsonMap);
  }
}