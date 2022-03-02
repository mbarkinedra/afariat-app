import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/notification_json.dart';

class PutNotificationApi extends ApiManager {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.putNotificationUrl +"/"+ id;
  }

  @override
  fromJson(data) {
    return NotificationJson.fromJson(data);
  }
}
