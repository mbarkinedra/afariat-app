import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/notification_json.dart';

class DeleteNotificationApi extends ApiManager {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.deleteNotificationUrl + "/" + id;
  }

  @override
  fromJson(data) {
    return NotificationJson.fromJson(data);
  }
}
