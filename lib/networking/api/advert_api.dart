import 'package:afariat/model/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/advert_list_json.dart';

class AdvertApi extends ResourceApi {
  @deprecated
  String url;

  @override
  @deprecated
  String apiUrl() {
    String parameters =
        Filter.toHttpQuery() != '' ? '?' + Filter.toHttpQuery() : '';

    if (url != null) {
      return SettingsApp.baseUrl + url;
    } else {
      return SettingsApp.advertUrl + parameters;
    }
  }

  @override
  Future<dynamic> getCollection(String url,
      {Map<String, dynamic> filters}) async {
    //if user is logged in, use the secure call.

    if (accountInfoStorage.isLoggedIn()) {
      return await secureGetCollection(url, filters: filters);
    }
    return await super.getCollection(url, filters: filters);
  }

  @override
  @Deprecated('use getCollection')
  Future<dynamic> getList({Map<String, dynamic> filters}) async {
    //if user is logged in, use the secure call.
    if (accountInfoStorage.isLoggedIn()) {
      return await secureGetList(filters: filters);
    }
    return await super.getList(filters: filters);
  }

  @override
  String apiPostUrl({dataToPost}) {
    return SettingsApp.publishURL;
  }

  @override
  String apiPutUrl({Map<String, String> queryParams}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }

  @override
  String apiDeleteUrl(String id) {
    // TODO: implement apiDeleteUrl
    throw UnimplementedError();
  }

  @override
  fromJson(data) {
    return AdvertListJson.fromJson(data);
  }

  @override
  String baseApiUrl() {
    return SettingsApp.advertUrl;
  }

  String generateUrl(String httpQuery) {
    return SettingsApp.apiPrefix +
        '/adverts' +
        (httpQuery != '' ? '?' + httpQuery : '');
  }

  Future<dynamic> getAdverts({String httpQuery}) async {
    String _url = baseApiUrl() + (httpQuery != '' ? '?' + httpQuery : '');
    if (accountInfoStorage.isLoggedIn()) {
      return await secureGetCollection(_url);
    }
    return await super.getCollection(_url);
  }
}
