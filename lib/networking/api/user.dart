
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/user_json.dart';

class UserApi extends ResourceApi {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.userUrl + "/" + id;
  }

  @override
  String apiDeleteUrl(String id) {
    return SettingsApp.userUrl + "/" + id;
  }

  @override
  String apiPutUrl({dataToPost}) {
    return SettingsApp.userUrl + "/" + id;
  }

  @override
  String apiPostUrl(dataToPost) {
    return SettingsApp.registerUrl;
  }

  @override
  fromJson(data) {
    return UserJson.fromJson(data);
  }
}