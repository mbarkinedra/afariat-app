import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';

class AdvertApi extends ApiManager {
  String myUrl;
  @override
  String apiUrl() {
    String parameters =
        Filter.toHttpQuery() != '' ? '?' + Filter.toHttpQuery() : '';

    String url = SettingsApp.advertUrl + parameters;
if(myUrl !=null){

  return url=SettingsApp.baseUrl+myUrl;
}else
    return url;
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }

}
