import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/notification_json.dart';

class NotificationApi extends ApiManager {
  @override
  int page = 0;

  String apiUrl() {
    String url = "?sort=a.modifiedAt&direction=desc&page=$page&limit=20";

    return SettingsApp.notificationUrl + url;
  }

  @override
  fromJson(data) {
    return NotificationJson.fromJson(data);
  }
}
