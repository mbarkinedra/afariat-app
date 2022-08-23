import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/api/abstract_password_api.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewController extends GetxController {
  TextEditingController password = TextEditingController();
  ForgotPasswordApi _forgotPasswordApi = ForgotPasswordApi();
  ServerValidator validateServer = ServerValidator();

  ParameterBag userData = ParameterBag();

  forgotPassword() {
    userData.data["username"] = password.text;
    _forgotPasswordApi.post(userData.data).then((value) {
      if (value == null) {
        //a 500 error perhaps. No need to continue validating the server response
        return;
      }
      validateServer.validateServer(
        success: () {},
        failure: () {},
        value: value,
      );
      Get.snackbar("message", value.data["message"]);
    }).catchError((error) {
    });
  }
}
