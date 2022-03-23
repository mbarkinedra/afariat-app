import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';

//TODO: Remove this file. Used advert_api instead
class AdvertPageApi extends ApiManager {
  String pagelink;
  @override
  String apiUrl() {
    throw new Exception('Should not be used. Use api_advert instead');
    return SettingsApp.baseUrl+pagelink;
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }
}
