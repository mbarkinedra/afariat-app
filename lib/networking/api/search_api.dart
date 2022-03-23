import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/adverts_json.dart';

import 'api_manager.dart';

//TODO: Remove this file. Used advert_api instead

class SearchApi extends ApiManager {
  Map<String, dynamic> map = {};

  String searchData = "";

  @override
  String apiUrl() {
    throw new Exception('Should not be used. Use api_advert instead');
    return SettingsApp.advertPageUrl + searchData;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return AdvertListJson.fromJson(data);
  }
}
