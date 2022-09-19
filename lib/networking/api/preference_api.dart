import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/preference_json.dart';
import 'package:dio/dio.dart';

class PreferenceApi extends ResourceApi {
  String id;

  /// Get preference's list
  @override
  String apiUrl() {
    return SettingsApp.preference;
  }

  @override
  String apiPostUrl({dataToPost}) {
    throw UnimplementedError();
  }

  @override
  String apiPutUrl({Map<String, String> queryParams}) {
    String id = queryParams['id'];
    int value = (queryParams['value'].toLowerCase() == 'true' ? 1 : 0 );
    return apiUrl() + "/$id/" + value.toString();
  }

  @override
  String apiDeleteUrl(String id) {
    // TODO: implement apiDeleteUrl
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> putData({dataToPost}) async {
    return super.putData(dataToPost: {});
  }

  @override
  fromJson(data) {
    return PreferenceJson.fromJson(data);
  }
}
