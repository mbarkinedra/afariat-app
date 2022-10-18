import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../json/post_json_response.dart';

class AbuseApi extends ApiManager {
  @override
  @deprecated
  String apiUrl() {
    return baseApiUrl();
  }

  @override
  String baseApiUrl() {
    return SettingsApp.abuse;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  ///Send an abuse
  Future<PostJsonResponse> sendReport({
    @required int advertId,
    @required String message,
    @required int categoryId,
    String email,
  }) async {
    Map<String, dynamic> dataToSend = {
      "message": message,
      "category": categoryId,
      "advert": advertId
    };

    Response<dynamic> response;
    if (accountInfoStorage.isLoggedIn()) {
      response = await postToUrl(
          url: baseApiUrl(), dataToPost: dataToSend, secure: true);
    } else {
      dataToSend["email"] = email;
      response = await postToUrl(
          url: baseApiUrl(), dataToPost: dataToSend, secure: false);
    }

    return PostJsonResponse.fromJson(response.data);
  }
}
