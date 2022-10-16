import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/api/abstract_password_api.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../networking/json/post_json_response.dart';
import '../../validator/form_validator.dart';

class ForgotPasswordViewController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  final ForgotPasswordApi _api = ForgotPasswordApi();
  final FormValidator _formValidator = FormValidator();

  RxBool isSending = false.obs;

  @override
  void onInit() {
    isSending.value = false;
    super.onInit();
  }

  RxBool success = false.obs;
  RxString error = ''.obs;

  forgotPassword() async {
    String username = usernameController.text.trim();
    error.value = '';
    if (username.isEmpty) {
      error.value = 'Veuillez saisir votre adresse email';
      return;
    }

    isSending.value = true;

    PostJsonResponse jsonResponse =
        await _api.requestResetPassword(username);
    print(jsonResponse.toJson());
    if (jsonResponse == null) {
      //probably it's a 500 error. TODO: FIX this in api_manager
      return;
    }

    _formValidator.validateServer(
      postJsonResponse: jsonResponse,
      success: () {
        success.value = true;
      },
      failure: () {
        error.value = jsonResponse.message;
      },
      authFailure: (){
        error.value = jsonResponse.message;
      }
    );

    isSending.value = false;
  }

  clearUsernameField() {
    usernameController.clear();
  }
}
