import 'dart:convert';

import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/user_json.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../model/device_info_model.dart';
import '../../model/filter.dart';
import '../../model/user.dart';
import '../../storage/AccountInfoStorage.dart';
import '../../utils/utils.dart';
import '../json/post_json_response.dart';
import '../json/simple_json_resource.dart';
import '../security/wsse.dart';

class UserApi extends ApiManager {
  @override
  fromJson(data) {
    return UserJson.fromJson(data);
  }

  ///Get the user salt
  Future<SimpleJsonResource> getUser(int id) async {
    String url = baseApiUrl() + "/" + id.toString();
    DIO.Response<dynamic> response = await securedGet(url, toJson: false);
    return SimpleJsonResource.fromJson(response.data);
  }

  ///Get the user salt
  Future<DIO.Response<dynamic>> getSalt(String username) async {
    ParameterBag dataToPost = ParameterBag();
    dataToPost.set('login', username);
    return await postToUrl(
        url: SettingsApp.getSaltUrl, dataToPost: dataToPost.data);
  }

  ///Login a user
  Future<SimpleJsonResource> login(String username, String password) async {
    DIO.Response response = await getSalt(username);
    SimpleJsonResource json = SimpleJsonResource.fromJson(response.data);
    if (json.code != 200) {
      //User not found
      return json;
    }
    String hashedPassword = Wsse.hashPassword(password, json.message);
    String wsse = Wsse.generateWsseHeader(username, hashedPassword);
    DeviceInfoModel info = await DeviceInfo.commonInfo();
    String jsonInfo = info.toJson();
    String base64Info = base64.encode(utf8.encode(jsonInfo));
    return await dioSingleton.dio
        .get(
      SettingsApp.loginUrl,
      options: DIO.Options(
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
        .then((value) async {
      validateResponseStatusCode(value);

      SimpleJsonResource jsonLogin = SimpleJsonResource.fromJson(value.data);
      if (jsonLogin.code == 200) {
        await _saveUserInfo(username, hashedPassword, jsonLogin.message.toString());
      }
      return jsonLogin;
    }).catchError((error, stackTrace) {
      processServerError(error);
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
    });
  }

  ///Register a user
  Future<PostJsonResponse> register(User user) async {
    DIO.Response<dynamic> response =
        await postToUrl(url: baseApiUrl(), dataToPost: user.toJson());
    return PostJsonResponse.fromJson(response.data);
  }

  ///Register a user
  Future<PostJsonResponse> update(UserJson user) async {
    String url = baseApiUrl() + "/" + user.id.toString();
    DIO.Response<dynamic> response =
        await putToUrl(url: url, dataToSend: user.toJson(form: true), secure: true);
    return PostJsonResponse.fromJson(response.data);
  }

  /// Update the password of the current loggedIn user
  Future<PostJsonResponse> changePassword(
      String currentPassword, String plainPassword) async {
    ParameterBag dataToSend = ParameterBag();
    dataToSend.set('currentPassword', currentPassword);
    dataToSend.set('plainPassword', plainPassword);

    DIO.Response<dynamic> response = await putToUrl(
        url: SettingsApp.changePasswordUrl,
        dataToSend: dataToSend.data,
        secure: true);

    PostJsonResponse postJsonResponse =
        PostJsonResponse.fromJson(response.data);
    //if updated success, update the hashed password in local storage
    //Retrieve the new salt and generate the new hash password.
    if (postJsonResponse.code == 200) {
      String username = accountInfoStorage.readEmail();
      DIO.Response response = await getSalt(username);
      SimpleJsonResource json = SimpleJsonResource.fromJson(response.data);
      if (json.code != 200) {
        //Important: Error happen and hashed password is no longer valid. force the user to logout/login
        await accountInfoStorage.logout();
      } else {
        String hashedPassword = Wsse.hashPassword(plainPassword, json.message);
        await accountInfoStorage.saveHashedPassword(hashedPassword);
      }
    }
    return postJsonResponse;
  }

  ///Register a user
  Future<PostJsonResponse> deleteUserById(int id) async {
    String url = baseApiUrl() + "/" + id.toString();
    DIO.Response<dynamic> response = await delete(url: url);
    PostJsonResponse jsonResponse = PostJsonResponse.fromJson(response.data);
    //if delete success. logout the user
    if (jsonResponse.code == 200) {
      await accountInfoStorage.logout();
    }
    return jsonResponse;
  }

  _saveUserInfo(String email, String hashedPassword, String userId) async {
    AccountInfoStorage infoStorage = Get.find<AccountInfoStorage>();
    infoStorage.saveEmail(email);
    await infoStorage.saveHashedPassword(hashedPassword);
    infoStorage.saveUserId(userId.toString());
  }

  @override
  String baseApiUrl() {
    return SettingsApp.userUrl;
  }

  @override
  @deprecated
  String apiUrl() {
    return baseApiUrl();
  }
}

class LogoutApi extends UserApi {
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
      options: DIO.Options(
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

/*class SignUpApi extends UserApi {
  @override
  String apiUrl() {
    return SettingsApp.registerUrl;
  }

  @override
  String baseApiUrl() {
    return SettingsApp.registerUrl;
  }
}


class SaltApi extends UserAPi {
  @override
  @deprecated
  String apiUrl() {
    return baseApiUrl();
  }

  @override
  String baseApiUrl() {
    return SettingsApp.getSaltUrl;
  }

  Future<Response<dynamic>> getSalt(String username) async {
    ParameterBag dataToPost = ParameterBag();
    dataToPost.set('login', username);
    return await postToUrl(url: baseApiUrl(), dataToPost: dataToPost.data);
  }

}*/
