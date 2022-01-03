import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

class PublishApi extends ApiManager {
  Map <String, dynamic>data = {};

  @override
  String apiUrl() {
    return SettingsApp.publishURL;
  }
  @override
  Map dataToPost() {
    return data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return data;
  }
}