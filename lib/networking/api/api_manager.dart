import 'dart:convert';

import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart' as a;



abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  final storge = a.Get.find<SecureStorage>();

  /// Returns the API URL of current API ressource
  String apiUrl();

  // Headers responseHeaders;
  NetWorkController _netWorkController=  a.Get.find<NetWorkController>();
  AbstractJsonResource fromJson(data);

  Future<dynamic> getList({Map<String, dynamic> filters}) async {

    AbstractJsonResource jsonList;
    var data;

      await dioSingleton.dio
          .get(apiUrl(), queryParameters: filters)
          .then((value) {
        // print("value.dabbbbbbbbbbbbbbbbbbbbbbbbbbta");
        // var logger = Logger();
        //
        // logger.d(value.data);
        //devlog.log(value.data.toString() );
        data = value.data;
      });
      print("CALLED URL: ${apiUrl()}");
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
              return status < 500;
            }),
      )
          .then((value) {
//      responseHeaders = value.headers;

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
    if(_netWorkController.connectionStatus.value){
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
              return status < 500;
            }),
      )
          .then((value) {

        return value;
      }).onError((error, stackTrace) {
        if(error.type == DioErrorType.connectTimeout){
          a.Get.snackbar("erreur", "Connection  Timeout");
          // throw Exception("Connection  Timeout Exception");
        }

        print(error);
        return error;

      });
    }else{
      a.Get.snackbar("erreur", "y hav not connction");
    }

  }

  /// Get Data  User From Server
  Future<Response<dynamic> > secureGet({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();

    String wsse = xwsse.generateWsseFromStorage();
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
     // print(value.data);

      return value;
    }).onError((error, stackTrace) {
      return error;

    });
  }

  Future<Response<dynamic>> putData({dataToPost}) async {
    //generer le wsse

    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    print(wsse);
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
              return status < 500;
            }),
      )
          .then((value) {
        //  responseHeaders = value.headers;
        //  print(value.data);
        return value;
      }).onError((error, stackTrace) {
        if(error.type == DioErrorType.connectTimeout){
          a.Get.snackbar("erreur", "Connection  Timeout");
          // throw Exception("Connection  Timeout Exception");
        }

        print(error);
        return error;

      });
    }else{
      a.Get.snackbar("erreur", "y hav not connction");
    }

  }
  Future getdata(Map<String, dynamic> dataToPost) async {
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
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
print(error);
      return error;
    });
  }

  /// del DATA TO SERVER
  Future<Response<dynamic>> delPost() async {
    //generer le wsse
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    print(wsse);
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio.delete(apiUrl(), options: options).then((value) {
      return value;
    }).onError((error, stackTrace) {

      return error;
    });
  }

  //Delete User From User
  Future<Response<dynamic>> deleteData() async {
    //generer le wsse
    Wsse xwsse = Wsse();
    String wsse = xwsse.generateWsseFromStorage();
    print(wsse);
    Options options = Options(headers: {
      "Accept": "application/json",
      'apikey': SettingsApp.apiKey,
      'Content-Type': 'application/json',
      'X-WSSE': wsse,
    });
    return dioSingleton.dio.delete(apiUrl(), options: options).then((value) {
      return value;
    }).onError((error, stackTrace) {
      print(error);
      return error;

    });
  }

 /* void processNetworkErro(error){

    // show snack bar for error.
  }*/
}
