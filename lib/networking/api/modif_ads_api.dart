import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/modif_ads_json.dart';

import 'api_manager.dart';

class ModifAdsApi extends ApiManager {
  int id;

  @override
  String apiUrl() {
    return SettingsApp.modifAds + "/" + id.toString();
  }

  @override
  AbstractJsonResource fromJson(data) {
    return ModifAdsJson.fromJson(data);
  }

  @override
  String baseApiUrl() {
    return SettingsApp.modifAds;
  }
}
