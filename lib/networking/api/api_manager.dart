import 'dart:convert';

import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/storage/storage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' as a;
import 'package:get/get_core/src/get_main.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  final storge = a.Get.find<SecureStorage>();

  /// Returns the API URL of current API ressource
  String apiUrl();

  // Headers responseHeaders;
  NetWorkController _netWorkController = a.Get.find<NetWorkController>();

  AbstractJsonResource fromJson(data);

  processServerError(error) {
    String message;
    if (error.response == null) {
      message = 'Problème réseau.';
    } else {
      switch (error.response.statusCode) {
        case 405:
          message = 'Merci de contacter le service client. Code: 405';
          break;

        case 500:
          message = 'Erreur serveur. Merci de contacter le service client.';
          break;

        case 503:
          message = 'Le serveur est surchargé. '
              'Veuillez ré-essayer un peu plus tard.';
          break;

        default:
          message = 'Merci de contacter le service client. ';
      }
      Get.snackbar(
        'Erreur',
        message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

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
    return dioSingleton.dio
        .post(
      apiUrl(),
      data: jsonEncode(dataToPost),
      options: Options(
          headers: {
            "Accept": "application/json",
            'apikey': SettingsApp.apiKey,
            'Content-Type': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      return value;
    }).catchError((error) {
      processServerError(error);
    });
  }

  /// POST DATA TO SERVER
  Future<Response<dynamic>> securePost({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();

    String wsse = xwsse.generateWsseFromStorage();
    if (_netWorkController.connectionStatus.value) {
      return dioSingleton.dio
          .post(
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
              return status < 405;
            }),
      )
          .then((value) {
        return value;
      }).catchError((error, stackTrace) {
        if (error.type == DioErrorType.connectTimeout) {
          a.Get.snackbar("erreur", "Connection  Timeout");
        }
        processServerError(error);

      });
    } else {
      a.Get.snackbar("erreur", "vous n'avez pas de connexion");
      return null;
    }
  }

  /// Get Data  User From Server
  Future<Response<dynamic>> secureGet({dataToPost}) async {
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();

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
            return status < 405;
          }),
    )
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  Future<Response<dynamic>> putData({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    if (_netWorkController.connectionStatus.value) {
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
              return status < 405;
            }),
      )
          .then((value) {
        return value;
      }).catchError((error, stackTrace) {
        if (error.type == DioErrorType.connectTimeout) {
          a.Get.snackbar("erreur", "Délai de connection dépassé");
          // throw Exception("Connection  Timeout Exception");
        }
        processServerError(error);
      });
    } else {
      a.Get.snackbar("erreur", "Délai de connection dépassé");
      return null;
    }
  }

  Future getData(Map<String, dynamic> dataToPost) async {
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
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
            return status < 405;
          }),
    )
        .then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  /// del DATA TO SERVER
  Future<Response<dynamic>> deleteAdverts() async {
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
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  //Delete User From User
  Future<Response<dynamic>> deleteData() async {
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
    }).catchError((error, stackTrace) {
      print(error);

      processServerError(error);
    });
  }
}
