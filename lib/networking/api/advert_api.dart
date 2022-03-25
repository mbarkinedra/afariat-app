import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';

class AdvertApi extends ApiManager {
  String url;

  @override
  String apiUrl() {
    String parameters =
        Filter.toHttpQuery() != '' ? '?' + Filter.toHttpQuery() : '';

    String defaultUrl = SettingsApp.advertUrl + parameters;
    if (url != null) {
      return defaultUrl = SettingsApp.baseUrl + url;
    } else
      return defaultUrl;
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }
}
