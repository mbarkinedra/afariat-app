import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/advert_details_json.dart';

class AdvertDetailsApi extends ApiManager {
  int advertTypeId;

  @override
  String apiUrl() {
    return SettingsApp.advertDeatilsUrl + "/" + advertTypeId.toString();
  }

  @override
  Future<dynamic> getResource() async {
    //if user is logged in, use the secure call.
    if (this.accountInfoStorage.isLoggedIn()) {
      return await this.secureGetResource();
    }
    return await super.getResource();
  }

  @override
  fromJson(data) {
    return AdvertDetailsJson.fromJson(data);
  }
}
