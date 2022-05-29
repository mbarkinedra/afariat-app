import 'package:afariat/networking/security/wsse.dart';
import 'api_manager.dart';
import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';

abstract class ResourceApi extends ApiManager {
  ///Returns the API DELETE URL of given resource ID
  String apiDeleteUrl(String id);

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
}
