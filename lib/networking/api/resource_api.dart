import 'dart:convert';

import 'package:afariat/networking/security/wsse.dart';
import '../../config/Environment.dart';
import 'api_manager.dart';
import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';

abstract class ResourceApi extends ApiManager {
  ///Returns the API DELETE URL of given resource ID
  String apiDeleteUrl(String id);

  ///Returns the API Put URL of given resource {dataToPost}
  String apiPutUrl({dataToPost});

  ///Returns the API POST URL of given resource {dataToPost}
  String apiPostUrl({dataToPost});

  //Delete User From User
  Future<Response<dynamic>> deleteResource(String id) async {
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': Environment.apikey,
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
    print(dataToPost);
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(
        headers: {
          "Accept": "application/json",
          'apikey': Environment.apikey,
          'Content-Type': 'application/json',
          'X-WSSE': wsse,
        },
        validateStatus: (status) {
          return status < 405;
        });

    return dioSingleton.dio
        .put(
      apiPutUrl(),
      options: options,
      data: jsonEncode(dataToPost),
    )
        .then((value) {
          print(value.statusCode);
          print(value.data);
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  /// POST DATA TO SERVER
  Future<Response<dynamic>> postResource({dataToPost}) async {
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': Environment.apikey,
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
