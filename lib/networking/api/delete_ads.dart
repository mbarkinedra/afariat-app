import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

import 'api_manager.dart';

class DeleteAds extends ApiManager {
  int id;

  @override
  String apiUrl() {
    return SettingsApp.deleteAds + "/" + id.toString();
  }

  @override
  AbstractJsonResource fromJson(data) {}
}
