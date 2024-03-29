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
  @deprecated
  String apiPutUrl({Map<String, String>queryParams});

  ///Returns the API POST URL of given resource {dataToPost}
  @deprecated
  String apiPostUrl({dataToPost});

  //Delete User From User
  //Get one resource
  @deprecated
  @Deprecated('Use delete method instead of this')
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

  ///Put User From User
  @deprecated
  Future<Response<dynamic>> putResource({dataToPost, Map<String, String>queryParams}) async {
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
      apiPutUrl(queryParams: queryParams),
      options: options,
      data: jsonEncode(dataToPost),
    )
        .then((value) {
      validateResponseStatusCode(value);
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  /// POST DATA TO SERVER
  @deprecated
  @Deprecated('Use post method instead of this')
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
          print('TOTOTO');
          print(value);
      validateResponseStatusCode(value);
      return value;
    }).catchError((error, stackTrace) {
      throw error;
      processServerError(error);
    });
  }
}
