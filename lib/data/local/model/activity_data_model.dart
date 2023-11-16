import 'activity.dart';

class ActivityData {
  List<Activity>? activities;

  ActivityData({this.activities});

  ActivityData.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activity>[];
      json['activities'].forEach((v) {
        activities!.add(Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
