import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:afariat/networking/json/adverts_json.dart';

class AdvertDetailsApi extends ApiManager {
  int advertTypeId;
  @override
  String apiUrl() {
    return SettingsApp.advertDeatilsUrl + advertTypeId.toString();;
  }

  @override
  fromJson(data) {
    return AdvertDetails.fromJson(data);
  }
}
