import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

class SignUpApi extends ApiManager {
  Map<String, dynamic> data = {};

  @override
  String apiUrl() {
    return SettingsApp.registerUrl;
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
