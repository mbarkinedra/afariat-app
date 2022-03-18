import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';

class AdvertApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.advertUrl;
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }

  // @override
  // void processNetworkErro(error){
  //   super.processNetworkErro(error);
  //
  //   // show the submit button
  // }
}
