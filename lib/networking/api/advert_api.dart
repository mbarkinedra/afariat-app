import 'package:afariat/model/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';

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
  Future<dynamic> getList({Map<String, dynamic> filters}) async {
    print(filters);
    print('TOTO');
    //if user is logged in, use the secure call.
    if (this.accountInfoStorage.isLoggedIn()) {
      return await this.secureGetList(filters: filters);
    }
    return await super.getList(filters: filters);
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }
}
