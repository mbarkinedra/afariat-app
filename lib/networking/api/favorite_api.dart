import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:dio/dio.dart';

class FavoriteApi extends ResourceApi {
  String _deleteUrl;
  String id;

  String url;

  @override
  String apiUrl() {
    if (url != null) {
      return  SettingsApp.baseUrl + url;
    } else {
      return SettingsApp.favorite;
    }
  }

  @override
  String apiDeleteUrl(String id) {
    return _deleteUrl + "/" + id;
  }

  @override

  /// Delete Advert from list favorite
  Future<Response<dynamic>> deleteResource(String id) async {
    _deleteUrl = SettingsApp.favorite;
    return super.deleteResource(id);
  }

  /// Delete Favorite from list Advert
  Future<Response<dynamic>> deleteByAdvertId(String advertId) async {
    _deleteUrl = SettingsApp.deleteFavoriteByAdvert;
    return super.deleteResource(advertId);
  }

  @override
  String apiPostUrl({dataToPost}) {
    return SettingsApp.favorite;
  }

  @override
  String apiPutUrl({Map<String, String> queryParams}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }

  @override
  fromJson(data) {
    return FavoriteListJson.fromJson(data);
  }
}
