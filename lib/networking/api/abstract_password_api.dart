import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/forgot_password_json.dart';
import 'package:dio/dio.dart';

import '../../model/filter.dart';
import '../json/post_json_response.dart';

abstract class AbstractPasswordApi extends ApiManager {
  @override
  fromJson(data) {
    return ForgotPasswordJson.fromJson(data);
  }
}

class ChangePasswordApi extends AbstractPasswordApi {
  @override
  @deprecated
  String apiUrl() {
    return baseApiUrl();
  }

  @override
  String baseApiUrl() {
    return SettingsApp.changePasswordUrl;
  }
}

class ForgotPasswordApi extends AbstractPasswordApi {
  @override
  @deprecated
  String apiUrl() {
    return baseApiUrl();
  }

  @override
  String baseApiUrl() {
    return SettingsApp.resetPasswordUrl;
  }

  Future<PostJsonResponse> requestResetPassword(String email) async {
    ParameterBag dataToPost = ParameterBag();
    dataToPost.set('username', email);
    Response<dynamic> response =
        await postToUrl(url: baseApiUrl(), dataToPost: dataToPost.data);
    return PostJsonResponse.fromJson(response.data);
  }
}
