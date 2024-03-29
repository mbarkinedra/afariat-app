import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/user_json.dart';

class UserApi extends ResourceApi {
  String id;
  String url;

  @override
  String apiUrl() {
    return SettingsApp.userUrl + "/" + id;
  }

  @override
  String apiDeleteUrl(String id) {
    return SettingsApp.userUrl + "/" + id;
  }

  @override
  String apiPutUrl({Map<String, String> queryParams}) {
    return SettingsApp.userUrl + "/" + id;
  }

  @override
  fromJson(data) {
    return UserJson.fromJson(data);
  }

  @override
  String apiPostUrl({dataToPost}) {
    // TODO: implement apiPostUrl
    throw UnimplementedError();
  }

  @override
  String baseApiUrl() {
    return SettingsApp.userUrl;
  }
}
