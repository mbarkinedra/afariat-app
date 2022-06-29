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
import '../../storage/AccountInfoStorage.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  final storage = a.Get.find<SecureStorage>();
  AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();

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

  //Get one resource
  Future<dynamic> getResource() async {
    var data;
    await dioSingleton.dio.get(apiUrl()).then((value) {
      data = value.data;
    });
    return fromJson(data);
  }

  // Get one resource by secure method
  Future<dynamic> secureGetResource() async {
    var json = await this.secureGet();
    return fromJson(json.data);
  }

  // Get list of resources
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

  // Get list of resources using the secure method
  Future<dynamic> secureGetList({Map<String, dynamic> filters}) async {
    AbstractJsonResource jsonList;

    var json = await this.secureGet();
    jsonList = fromJson(json.data);

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

    String wsse = Wsse.generateWsseFromStorage();
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
  Future<Response<dynamic>> secureGet({Map<String, dynamic> filters}) async {
    String xwsse = Wsse.generateWsseFromStorage();
    return dioSingleton.dio
        .get(
      apiUrl(),
      queryParameters: filters,
      options: Options(
          headers: {
            "Accept": "application/json",
            'apikey': SettingsApp.apiKey,
            'Content-Type': 'application/json',
            'X-WSSE': xwsse,
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
    String wsse = Wsse.generateWsseFromStorage();
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

  Future getData() async {
    String wsse = Wsse.generateWsseFromStorage();
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
    String wsse = Wsse.generateWsseFromStorage();
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
}
