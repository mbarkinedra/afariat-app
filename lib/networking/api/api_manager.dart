import 'dart:convert';
import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/storage/storage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as a;
import 'package:get/get_core/src/get_main.dart';
import '../../config/Environment.dart';
import '../../storage/AccountInfoStorage.dart';
import '../../validator/validate_server.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  final storage = a.Get.find<SecureStorage>();
  AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
  ServerValidator validator = ServerValidator();

  Map<String, dynamic> defaultHeaders = {
    "Accept": "application/json",
    'apikey': Environment.apikey,
    'Content-Type': 'application/json',
  };

  /// Returns the API URL of current API ressource
  @deprecated
  @Deprecated('use baseApiUrl')
  String apiUrl();

  /// Returns the base API URL of current API ressource
  String baseApiUrl();

  // Headers responseHeaders;
  NetWorkController _netWorkController = a.Get.find<NetWorkController>();

  AbstractJsonResource fromJson(data);

  validateResponseStatusCode(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        //success
        break;
      case 400:
        Get.snackbar(
          'Erreur serveur 400',
          'Veuillez mettre à jour l\'application',
          /*colorText: Colors.white,
          backgroundColor: Colors.red,*/
        );
        break;
      case 401:
      case 403:
        //problem happens with auth: bad app key for 403 or 401 for bad credentials
        //Force the logout the user to be sure that he will login with the right credentials
        Get.find<AccountInfoStorage>().logout();
        Get.snackbar(
          'Important',
          'Vous êtes déconnecté. Veuillez vous connecter de nouveau.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        break;
      case 404:
        Get.snackbar(
          'Erreur',
          'Not found',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        break;
    }
    return response.statusCode;
  }

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
  Future<dynamic> get(String url) async {
    var data;
    await dioSingleton.dio.get(url).then((value) {
      validateResponseStatusCode(value);
      data = value.data;
    });
    return fromJson(data);
  }

  Future<Response<dynamic>> securedGet(String url,
      {Map<String, dynamic> filters}) async {
    String wsse = Wsse.generateWsseFromStorage();
    print('calling: $url');
    return dioSingleton.dio
        .get(
      url,
      queryParameters: filters,
      options: Options(
          headers: {
            ...defaultHeaders,
            ...{'X-WSSE': wsse},
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      //process server status codes
      validateResponseStatusCode(value);
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  Future<dynamic> getCollection(String url,
      {Map<String, dynamic> filters}) async {
    AbstractJsonResource jsonList;
    var data;

    await dioSingleton.dio.get(url, queryParameters: filters).then((value) {
      validateResponseStatusCode(value);
      data = value.data;
    });
    jsonList = fromJson(data);
    return jsonList;
  }

  Future<dynamic> secureGetCollection(String url,
      {Map<String, dynamic> filters}) async {
    AbstractJsonResource jsonList;

    var json = await securedGet(url, filters: filters);
    jsonList = fromJson(json.data);
    return jsonList;
  }

  /// POST DATA TO SERVER
  Future<Response<dynamic>> postToUrl({String url, dataToPost}) async {
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': Environment.apikey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio
        .post(
      url,
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

  //Delete a resource(s) by calling the given url
  Future<Response<dynamic>> delete(String url) async {
    String wsse = Wsse.generateWsseFromStorage();
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': Environment.apikey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio.delete(url, options: options).then((value) {
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }

  //Get one resource
  @deprecated
  @Deprecated('Use get method instead of this')
  Future<dynamic> getResource() async {
    var data;
    await dioSingleton.dio.get(apiUrl()).then((value) {
      validateResponseStatusCode(value);
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
  @Deprecated('use getCollection instead')
  Future<dynamic> getList({Map<String, dynamic> filters}) async {
    AbstractJsonResource jsonList;
    var data;

    await dioSingleton.dio
        .get(apiUrl(), queryParameters: filters)
        .then((value) {
      validateResponseStatusCode(value);
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }

  // Get list of resources using the secure method
  @deprecated
  @Deprecated('use secureGetCollection instead')
  Future<dynamic> secureGetList({Map<String, dynamic> filters}) async {
    AbstractJsonResource jsonList;

    var json = await secureGet(filters: filters);
    jsonList = fromJson(json.data);
    return jsonList;
  }

  /// POST DATA TO SERVER
  @deprecated
  @Deprecated(
      'Use postToUrl instead of this. later, delete post and rename postToUrl to post')
  Future<Response<dynamic>> post(dataToPost) async {
    return dioSingleton.dio
        .post(
      apiUrl(),
      data: jsonEncode(dataToPost),
      options: Options(
          headers: defaultHeaders,
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      validateResponseStatusCode(value);
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
              ...defaultHeaders,
              ...{'X-WSSE': wsse},
            },
            followRedirects: false,
            validateStatus: (status) {
              return status < 405;
            }),
      )
          .then((value) {
        validateResponseStatusCode(value);
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
  @Deprecated('Use securedGet instead')
  Future<Response<dynamic>> secureGet({Map<String, dynamic> filters}) async {
    String wsse = Wsse.generateWsseFromStorage();
    return dioSingleton.dio
        .get(
      apiUrl(),
      queryParameters: filters,
      options: Options(
          headers: {
            ...defaultHeaders,
            ...{'X-WSSE': wsse},
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      //process server status codes
      validateResponseStatusCode(value);
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
              ...defaultHeaders,
              ...{'X-WSSE': wsse},
            },
            followRedirects: false,
            validateStatus: (status) {
              return status < 405;
            }),
      )
          .then((value) {
        validateResponseStatusCode(value);
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
            ...defaultHeaders,
            ...{'X-WSSE': wsse},
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 405;
          }),
    )
        .then((value) {
      validateResponseStatusCode(value);
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
      ...defaultHeaders,
      ...{'X-WSSE': wsse},
    });
    return dioSingleton.dio.delete(apiUrl(), options: options).then((value) {
      validateResponseStatusCode(value);
      return value;
    }).catchError((error, stackTrace) {
      processServerError(error);
    });
  }
}
