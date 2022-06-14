import 'package:afariat/networking/api/resource_api.dart';
import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/notification_json.dart';

class NotificationApi extends ResourceApi {
  String url;
  String id;
  int page = 0;

  @override
  String apiUrl() {
    return url;
  }

  @override
  String apiDeleteUrl(String id) {
    return SettingsApp.deleteNotificationUrl + "/" + id;
  }

  @override
  fromJson(data) {
    return NotificationJson.fromJson(data);
  }

  @override
  Future<Response<dynamic>> secureGet({Map<String, dynamic> filters}) async {
    url = SettingsApp.notificationUrl +
        "?sort=a.modifiedAt&direction=desc&page=$page&limit=20";
    return super.secureGet(filters: filters);
  }

  Future getUnread() {
    url = SettingsApp.notificationCountUrl;
    return this.getData();
  }

  Future<Response<dynamic>> putData({dataToPost}) async {
    url = SettingsApp.putNotificationUrl + "/" + id;
    return super.putData(dataToPost: {"id": id});
  }

  @override
  String apiPostUrl({dataToPost}) {
    // TODO: implement apiPostUrl
    throw UnimplementedError();
  }

  @override
  String apiPutUrl({dataToPost}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }
}
