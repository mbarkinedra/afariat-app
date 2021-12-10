import 'dart:convert';

import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();

  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);

  Future<dynamic> getList() async {
    print(Filter.m.toString());
    AbstractJsonResource jsonList;
    var data;
    await dioSingleton.dio
        .get(Filter.Id == null ? apiUrl() : apiUrl() + Filter.Id,
            queryParameters: Filter.m)
        .then((value) {
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }

  Future<Response<dynamic>> post(dataToPost) async {
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
}
