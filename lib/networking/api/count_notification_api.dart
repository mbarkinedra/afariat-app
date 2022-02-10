import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/count_notification_json.dart';
import 'package:afariat/networking/json/notification_json.dart';

class CountNotificationApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.notificationCountUrl;
  }

  @override
  fromJson(data) {
    return CountNotificationJson.fromJson(data);
  }
}
