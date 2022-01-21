import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/forgot_password_json.dart';

class ForgotPasswordApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.resetPasswordUrl;
  }

  @override
  fromJson(data) {
    return ForgotPasswordJson.fromJson(data);
  }
}
