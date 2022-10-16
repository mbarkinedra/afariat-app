import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../networking/json/post_json_response.dart';
import '../storage/AccountInfoStorage.dart';

class FormValidator {
  PostJsonResponse jsonResponse;

  /// value: is the entered user value, field: is the name of the field
  String validate(String value, String field) {
    if (jsonResponse == null || !jsonResponse.hasErrors()) {
      return null;
    }

    if (!jsonResponse.errors.hasField(field)) {
      return null;
    }

    PostJsonFieldError jsonFieldError = jsonResponse.errors.getField(field);

    return jsonFieldError?.first();
  }

  int validateServer(
      {PostJsonResponse postJsonResponse,
      Function success,
      Function failure,
      Function authFailure,
      Function notFound}) {
    jsonResponse = postJsonResponse;
    switch (jsonResponse.code) {
      case 200:
      case 201:
      case 204:
        success();
        break;
      case 422:
        failure();
        break;
      case 401:
      case 403:
        //Force the logout the user to be sure that he will login with the right credentials
        if(Get.find<AccountInfoStorage>().isLoggedIn()) {
          Get.find<AccountInfoStorage>().logout();
        }
        authFailure();
        break;
      case 404:
        notFound();
        break;
    }
    return jsonResponse.code;
  }
}
