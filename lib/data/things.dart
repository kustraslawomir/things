class Things {
  List<Activities>? activities;

  Things({this.activities});

  Things.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(Activities.fromJson(v));
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

class Activities {
  String? date;
  String? title;

  Activities({this.date, this.title});

  Activities.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['title'] = title;
    return data;
  }
}
