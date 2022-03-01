import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/notification_json.dart';

class NotificationApi extends ApiManager {
  @override

  String apiUrl() {
    return SettingsApp.notificationUrl;
  }

  @override
  fromJson(data) {
    return NotificationJson.fromJson(data);
  }
}
