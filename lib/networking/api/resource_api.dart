import 'dart:convert';

import 'package:afariat/networking/security/wsse.dart';
import 'api_manager.dart';
import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';

abstract class ResourceApi extends ApiManager {
  ///Returns the API DELETE URL of given resource ID
  String apiDeleteUrl(String id);

  String apiPutUrl({dataToPost});

  String apiPostUrl({dataToPost});

  //Delete User From User
  Future<Response<dynamic>> deleteResource(String id) async {
    //generer le wsse
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio
        .delete(apiDeleteUrl(id), options: options)
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  //Put User From User
  Future<Response<dynamic>> putResource({dataToPost}) async {
    //generer le wsse
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio
        .put(
      apiPutUrl(),
      options: options,
      data: jsonEncode(dataToPost),
    )
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  /// POST DATA TO SERVER
  Future<Response<dynamic>> postResource({dataToPost}) async {
    //generer le wsse
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio
        .post(
      apiPostUrl(),
      options: options,
      data: jsonEncode(dataToPost),
    )
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }
}
