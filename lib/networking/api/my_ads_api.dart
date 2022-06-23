import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/my_ads_json.dart';

class MyAdsApi extends ResourceApi {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.myAdsUrl + id + "&allAdverts=true";
  }

  @override
  String apiDeleteUrl(String id) {
    return SettingsApp.deleteAds + "/" + id;
  }

  @override
  String apiPostUrl({dataToPost}) {
    return SettingsApp.publishURL;
  }

  @override
  String apiPutUrl({dataToPost}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }

  @override
  fromJson(data) {
    return MyAdsJson.fromJson(data);
  }
}
