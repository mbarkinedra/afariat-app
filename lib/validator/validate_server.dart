import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../storage/AccountInfoStorage.dart';

class ServerValidator {
  Map<String, dynamic> serverErrors;

  /// value: is the entered user value, field: is the name of the field
  String validate(String value, String field) {
    //1st validate the front entered fields, then validate the errors from server
    String errorMessage;
    //validating server errors
    serverErrors.forEach((key, elementErrors) {
      if (field == key && elementErrors.containsKey('errors')) {
        if (elementErrors['errors'].length > 0) {
          errorMessage = elementErrors['errors'][0];
        }
      }
    });

    return errorMessage;
  }

  validateServer(
      {value,
      Function success,
      Function failure,
      Function authFailure,
      Function notFound}) {

    switch (value.statusCode) {
      case 200:
      case 201:
      case 204:
        success();
        break;
      case 400:
        serverErrors = value.data;
        failure();
        break;
      case 401:
      case 403:
        serverErrors = value.data;
        //Force the logout the user to be sure that he will login with the right credentials
        print('Force the logout');
        Get.find<AccountInfoStorage>().logout();
        authFailure();
        break;
      case 404:
        serverErrors = value.data;
        notFound();
        break;
    }
    return value.statusCode;
  }
}
