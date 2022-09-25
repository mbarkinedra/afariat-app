import 'package:afariat/model/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';

class AdvertApi extends ResourceApi {
  String url;

  @override
  String apiUrl() {
    String parameters =
        Filter.toHttpQuery() != '' ? '?' + Filter.toHttpQuery() : '';

    if (url != null) {
      return  SettingsApp.baseUrl + url;
    } else {
      return SettingsApp.advertUrl + parameters;
    }
  }

  @override
  Future<dynamic> getList({Map<String, dynamic> filters}) async {
    //if user is logged in, use the secure call.
    if (this.accountInfoStorage.isLoggedIn()) {
      return await this.secureGetList(filters: filters);
    }
    return await super.getList(filters: filters);
  }

  @override
  String apiPostUrl({dataToPost}) {
    return SettingsApp.publishURL;
  }

  @override
  String apiPutUrl({ Map<String, String>queryParams}) {
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
}
