import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/forgot_password_json.dart';

class ChangePasswordApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.changePasswordUrl;
  }

  @override
  fromJson(data) {
    return ForgotPasswordJson.fromJson(data);
  }
}
