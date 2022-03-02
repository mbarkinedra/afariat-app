import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/adverts_json.dart';

import 'api_manager.dart';

class SearchApi extends ApiManager {
  Map<String, dynamic> map = {};

  String searchData="";
  SearchApi(this.map) {
    Filter.data = map;
  }

  @override
  String apiUrl() {
    return SettingsApp.advertUrl+searchData;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return AdvertListJson.fromJson(data);
  }


}
