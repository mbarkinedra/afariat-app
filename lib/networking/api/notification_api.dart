import 'package:afariat/networking/api/resource_api.dart';
import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/notification_json.dart';

class NotificationApi extends ResourceApi {
  @deprecated
  String url;
  String id;
  int page = 0;

  @override
  @deprecated
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

  @override
  String apiPutUrl({ Map<String, String>queryParams}) {
    return SettingsApp.putNotificationUrl + "/" + id;
  }

  @override
  String apiPostUrl({dataToPost}) {
    // TODO: implement apiPostUrl
    throw UnimplementedError();
  }

  @override
  String baseApiUrl() {
    return SettingsApp.deleteNotificationUrl;
  }
}
