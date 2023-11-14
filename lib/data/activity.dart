import 'package:things/data/tag.dart';

class Activity {
  int? id;
  String? title;
  String? description;
  List<Tag>? tags;

  Activity({this.id, this.title, this.description, this.tags});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }

 String getDescriptionWithHashTags() {
    return "$description\n\n${tags?.map((e) => "#${e.name}").join(" ")}";
 }
}
