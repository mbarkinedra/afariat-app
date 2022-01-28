import 'dart:convert';

import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as a;
import 'dart:developer';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  final storge = a.Get.find<SecureStorage>();

  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);

  Future<dynamic> getList({Map<String, dynamic> filters}) async {
    AbstractJsonResource jsonList;
    var data;
    await dioSingleton.dio
        .get(apiUrl(), queryParameters: filters)
        .then((value) {
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }

  /// POST DATA TO SERVER
  Future<Response<dynamic>> post(dataToPost) async {
    print(jsonEncode(dataToPost));
    Options options = Options(
      headers: {
        "Accept": "application/json",
        'apikey': SettingsApp.apiKey,
        'Content-Type': 'application/json',
      },
    );
    return dioSingleton.dio
        .post(
      apiUrl(),
      data: jsonEncode(dataToPost),
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .then((value) {
      return value;
    }).catchError((error) {
      a.Get.snackbar("error", error.toString());
    });
  }

  /// POST DATA TO SERVER
  Future<Response<dynamic>> securePost({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();

    String wsse = xwsse.generateWsseFromStorage();
    print(wsse);
    print(jsonEncode(dataToPost));
    return dioSingleton.dio
        .post(
      apiUrl(),
      data: jsonEncode(dataToPost),
      options: Options(headers: {
        "Accept": "application/json",
        'apikey': SettingsApp.apiKey,
        'Content-Type': 'application/json',
        'X-WSSE': wsse,
      },
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  /// Get Data  User From Server
  Future<Response<dynamic>> secureGet({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();

    String wsse = xwsse.generateWsseFromStorage();
    print(jsonEncode(dataToPost));
    print(wsse);

    return dioSingleton.dio
        .get(
      apiUrl(),
      options: Options(
          headers: {
            "Accept": "application/json",
            'apikey': SettingsApp.apiKey,
            'Content-Type': 'application/json',
            'X-WSSE': wsse,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<Response<dynamic>> putData({dataToPost}) async {
    //generer le wsse
    print(jsonEncode(dataToPost));
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    print(wsse);
    return dioSingleton.dio
        .put(
      apiUrl(),
      data: jsonEncode(dataToPost),
      options: Options(
          headers: {
            "Accept": "application/json",
            'apikey': SettingsApp.apiKey,
            'Content-Type': 'application/json',
            'X-WSSE': wsse,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future getdata(Map<String, dynamic> dataToPost) async {
    Options options = Options(headers: {
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': dataToPost['X-WSSE'],
    });
    return dioSingleton.dio.get(apiUrl(), options: options);
  }

  /// del DATA TO SERVER
  Future<Response<dynamic>> delPost() async {
    //generer le wsse
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio.delete(apiUrl(), options: options).then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  //Delete User From User
  Future<Response<dynamic>> deleteUser() async {
    //generer le wsse
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio.delete(apiUrl(), options: options).then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
