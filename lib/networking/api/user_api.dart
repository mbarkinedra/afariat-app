import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/user_json.dart';

class UserApi extends ApiManager {
  String id;
  @override
  String apiUrl() {
    return SettingsApp.userUrl+ id ;
  }

  @override
  fromJson(data) {
    return UserJson.fromJson(data);
  }
}
