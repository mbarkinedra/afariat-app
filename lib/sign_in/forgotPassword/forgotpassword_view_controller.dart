import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/api/abstract_password_api.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  final ForgotPasswordApi _api = ForgotPasswordApi();
  ServerValidator validateServer = ServerValidator();

  RxBool isSending = false.obs;

  @override
  void onInit() {
    isSending.value = false;
    super.onInit();
  }

  RxBool success = false.obs;

  forgotPassword() async {
    if (usernameController.text.isEmpty) {
      Get.snackbar("Erreur", 'Veuillez saisir votre adresse email');
      return;
    }
    isSending.value = true;
    await _api.requestResetPassword(usernameController.text).then((value) {
      if (value == null) {
        //a 500 error perhaps. No need to continue validating the server response
        isSending.value = false;
        return;
      }
      validateServer.validateServer(
        success: () {
          success.value = true;
        },
        failure: () {
          Get.snackbar("Message", value.data["message"]);
        },
        value: value,
      );
    }).catchError((error) {
      print(error);
      throw error;
    });

    isSending.value = false;
  }

  clearUsernameField() {
    usernameController.clear();
  }
}
