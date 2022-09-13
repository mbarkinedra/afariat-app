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
            "Accept": "application/json",
            'apikey': Environment.apikey,
            'Content-Type': 'application/json',
            'X-WSSE': wsse,
            'X-DEVICEINFO': base64Info
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
}

class SignUpApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.registerUrl;
  }
}

class GetSaltApi extends AbstractUserAPi {
  @override
  String apiUrl() {
    return SettingsApp.getSaltUrl;
  }
}
