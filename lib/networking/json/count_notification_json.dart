import 'package:afariat/networking/json/abstract_json_resource.dart';

class CountNotificationJson extends AbstractJsonResource {
  int totalUnread;

  CountNotificationJson({this.totalUnread});

  CountNotificationJson.fromJson(Map<String, dynamic> json) {
    totalUnread = json['totalUnread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalUnread'] = this.totalUnread;
    return data;
  }
}
