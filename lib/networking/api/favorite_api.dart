import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:dio/dio.dart';

class FavoriteApi extends ResourceApi {
  String _deleteUrl;

  @override
  String apiUrl() {
    return SettingsApp.favorite;
  }

  @override
  String apiDeleteUrl(String id) {
    return _deleteUrl + "/" + id;
  }

  @override
  fromJson(data) {
    return FavoriteJson.fromJson(data);
  }

  @override
  Future<Response<dynamic>> deleteResource(String id) async {
    _deleteUrl = SettingsApp.favorite;
    return super.deleteResource(id);
  }

  Future<Response<dynamic>> deleteByAdvertId(String advertId) async {
    _deleteUrl = SettingsApp.deleteFavoriteByAdvert;
    return super.deleteResource(advertId);
  }

  @override
  String apiPostUrl({dataToPost}) {
    // TODO: implement apiPostUrl
    throw UnimplementedError();
  }

  @override
  String apiPutUrl({dataToPost}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }
}
