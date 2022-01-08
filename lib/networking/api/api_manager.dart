import 'dart:convert';

import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as a;

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
        'X-WSSE': dataToPost['X-WSSE'],
      },
    );
    return dioSingleton.dio
        .post(apiUrl(), data: jsonEncode(dataToPost), options: options

            // Options(
            //     followRedirects: false,
            //     validateStatus: (status) {
            //       return status < 500;
            //     }),
            )
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }


  /// POST DATA TO SERVER
  Future<Response<dynamic>> securePost({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();
   String nn= xwsse.generateWsseFromStorage();
    print(jsonEncode(dataToPost));
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': nn,
    });
    return dioSingleton.dio
        .post(apiUrl(), data: jsonEncode(dataToPost), options: options

            // Options(
            //     followRedirects: false,
            //     validateStatus: (status) {
            //       return status < 500;
            //     }),
            )
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future get(Map<String, dynamic> dataToPost) async {
    Options options = Options(headers: {
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': dataToPost['X-WSSE'],
    });
    return dioSingleton.dio.get(apiUrl(), options: options);
  }

  /// del DATA TO SERVER
  Future<Response<dynamic>> delPost({int id, wss}) async {
    //generer le wsse

    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wss,
    });
    return dioSingleton.dio
        .delete(apiUrl() + id.toString(), options: options

            // Options(
            //     followRedirects: false,
            //     validateStatus: (status) {
            //       return status < 500;
            //     }),
            )
        .then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
