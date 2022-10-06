import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/forgot_password_json.dart';

abstract class AbstractPasswordApi extends ApiManager {
  @override
  fromJson(data) {
    return ForgotPasswordJson.fromJson(data);
  }
}

class ChangePasswordApi extends AbstractPasswordApi {
  @override
  String apiUrl() {
    return SettingsApp.changePasswordUrl;
  }

  @override
  String baseApiUrl() {
    return SettingsApp.changePasswordUrl;
  }
}

class ForgotPasswordApi extends AbstractPasswordApi {
  @override
  String apiUrl() {
    return SettingsApp.resetPasswordUrl;
  }

  @override
  String baseApiUrl() {
    return SettingsApp.resetPasswordUrl;
  }
}