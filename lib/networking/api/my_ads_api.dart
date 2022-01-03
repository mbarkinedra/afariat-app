import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/my_ads_json.dart';

class MyAdsApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.myAdsUrl;
  }

  @override
  fromJson(data) {
    return MyAdsJson.fromJson(data);
  }
}
