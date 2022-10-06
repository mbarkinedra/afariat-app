import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:dio/dio.dart';

class FavoriteApi extends ResourceApi {
  @deprecated
  String _deleteUrl;

  @deprecated
  String id;

  @deprecated
  String url;

  @override
  @deprecated
  String apiUrl() {
    if (url != null) {
      return SettingsApp.baseUrl + url;
    } else {
      return SettingsApp.favorite;
    }
  }

  @override
  @deprecated
  String apiDeleteUrl(String id) {
    return _deleteUrl + "/" + id;
  }

  @override

  /// Delete Advert from list favorite
  @deprecated
  Future<Response<dynamic>> deleteResource(String id) async {
    _deleteUrl = SettingsApp.favorite;
    return super.deleteResource(id);
  }

  /// Delete Favorite from list Advert
  Future<Response<dynamic>> deleteByAdvertId(int id) async {
    String url = SettingsApp.deleteFavoriteByAdvert + "/" + id.toString();
    return delete(url);
  }

  /// Add Advert to user's favorite's list
  Future<Response<dynamic>> addAdvert(int id) async {
    String url = SettingsApp.favorite;
    return postToUrl(url: url, dataToPost: {'id': id});
  }

  @override
  @deprecated
  String apiPostUrl({dataToPost}) {
    return SettingsApp.favorite;
  }

  @override
  @deprecated
  String apiPutUrl({Map<String, String> queryParams}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }

  @override
  fromJson(data) {
    return FavoriteListJson.fromJson(data);
  }

  @override
  String baseApiUrl() {
    return SettingsApp.favorite;
  }
}
