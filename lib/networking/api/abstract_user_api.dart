import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/user_json.dart';

abstract class AbstractUserAPi extends ApiManager {
  @override
  fromJson(data) {
    return UserJson.fromJson(data);
  }
}

class SignInApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.loginUrl;
  }
}

class GetSaltApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.getSaltUrl;
  }
}
