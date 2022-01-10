import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';

class AdvertPageApi extends ApiManager {
  int page;
  @override
  String apiUrl() {
    return SettingsApp.advertPageUrl+page.toString();
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }
}
