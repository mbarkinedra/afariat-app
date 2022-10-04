import 'dart:convert';

import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/user_json.dart';
import 'package:dio/dio.dart';

import '../../config/Environment.dart';
import '../../model/device_info_model.dart';
import '../../utils/utils.dart';
import '../security/wsse.dart';

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

  Future login(String username, String hashedPassword) async {
    String wsse = Wsse.generateWsseHeader(username, hashedPassword);
    DeviceInfoModel info = await DeviceInfo.commonInfo();
    String jsonInfo = info.toJson();
    String base64Info = base64.encode(utf8.encode(jsonInfo));

    return dioSingleton.dio
        .get(
      apiUrl(),
      options: Options(
          headers: {
            ...defaultHeaders,
            ...{'X-WSSE': wsse},
            ...{'X-DEVICEINFO': base64Info}
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  @override
  String baseApiUrl() {
    return SettingsApp.loginUrl;
  }
}

class LogoutApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.logoutUrl;
  }

  Future logout() async {
    String wsse = Wsse.generateWsseFromStorage();
    DeviceInfoModel info = await DeviceInfo.commonInfo();
    String jsonInfo = info.toJson();
    String base64Info = base64.encode(utf8.encode(jsonInfo));

    return dioSingleton.dio
        .get(
      apiUrl(),
      options: Options(
          headers: {
            ...defaultHeaders,
            ...{'X-WSSE': wsse},
            ...{'X-DEVICEINFO': base64Info}
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  @override
  String baseApiUrl() {
    return SettingsApp.logoutUrl;
  }
}

class SignUpApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.registerUrl;
  }

  @override
  String baseApiUrl() {
    return SettingsApp.registerUrl;
  }
}

class GetSaltApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.getSaltUrl;
  }

  @override
  String baseApiUrl() {
    return SettingsApp.getSaltUrl;
  }
}
