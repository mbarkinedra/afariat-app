import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/user_json.dart';

abstract class User extends ApiManager {
  @override
  fromJson(data) {
    return UserJson.fromJson(data);
  }
}

class UserApi extends User {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.userUrl + "/" + id;
  }
}

class SignUpApi extends User {
  Map<String, dynamic> data = {};

  @override
  String apiUrl() {
    return SettingsApp.registerUrl;
  }
}

class SignInApi extends User {
  @override
  String apiUrl() {
    return SettingsApp.loginUrl;
  }
}

class GetSaltApi extends User {
  @override
  String apiUrl() {
    return SettingsApp.getSaltUrl;
  }
}
