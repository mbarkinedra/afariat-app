import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidateServer {
  Map<String, dynamic> serverErrors;

  /// value: is the entered user value, field: is the name of the field
  String validator(String value, String field) {
    //1st validate the front entered fields, then validate the errors from server
    //
    String errorMessage = null;

    //validating server errors
    serverErrors.forEach((key, elementErrors) {
      if (field == key && elementErrors.containsKey('errors')) {
        if (elementErrors['errors'].length > 0) {
          errorMessage = elementErrors['errors'][0];
        }
      }
    });

    return errorMessage ?? null;
  }

  validatorServer({value, Function validate, registerFormKey}) {
    switch (value.statusCode) {
      case 200:
        //Affichage success
        validate();

        break;
      case 201:
        //Affichage success
        validate();
        break;
      case 204:
        //Affichage success
        validate();
        break;
      case 400:
        print('------------------------------');
        serverErrors = value.data;
        value.data.forEach((key, value) {
          print('Key: $key');
          print('------------------------------');
        });
        registerFormKey.currentState.validate();
        Get.snackbar(
          'Erreur',
          'Veuillez corriger les erreurs ci-dessous.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );

        break;

      case 401:
        serverErrors = value.data;
        value.data.forEach((key, value) {
          print('Key: $key');
          print('------------------------------');
        });

        Get.snackbar(
          'Erreur',
          'Veuillez corriger les erreurs ci-dessous.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );

        break;
      case 403:
        serverErrors = value.data;
        value.data.forEach((key, value) {
          print('Key: $key');
          print('------------------------------');
        });

        Get.snackbar(
          'Erreur',
          'Veuillez corriger les erreurs ci-dessous.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        break;
      case 404:
        serverErrors = value.data;
        print(value.data);
        print(value.data['error']['message']);
        value.data.forEach((key, value) {
          print('Key: $key');
          print('------------------------------');
        });

        Get.snackbar(
          'Erreur',
          value.data['error']['message']//  'Veuillez corriger les erreurs ci-dessous.',
          ,colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        break;
      default:
        return;
    }
  }
}
