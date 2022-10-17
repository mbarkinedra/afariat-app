import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/advert_details_json.dart';

class AdvertDetailsApi extends ApiManager {
  String advertTypeId;

  @override
  String apiUrl() {
    return SettingsApp.advertDeatilsUrl + "/" + advertTypeId;
  }

  @override
  @deprecated
  @Deprecated('Use get method instead of this')
  Future<dynamic> getResource() async {
    //if user is logged in, use the secure call.
    if (accountInfoStorage.isLoggedIn()) {
      return await secureGetResource();
    }
    return await super.getResource();
  }

  @override
  fromJson(data) {
    return AdvertDetailsJson.fromJson(data);
  }

  @override
  String baseApiUrl() {
    SettingsApp.advertDeatilsUrl;
  }

  @override
  Future<dynamic> get(String url,  {Map<String, dynamic> filters, bool toJson = true}) async {
    if (accountInfoStorage.isLoggedIn()) {
      return await securedGet(url, toJson: toJson);
    }
    return await super.get(url, toJson: toJson);
  }

  Future<dynamic> getAdvert(String advertId) async {
    String _url = SettingsApp.advertDeatilsUrl + '/' + advertId;
    return get(_url);
  }
}
