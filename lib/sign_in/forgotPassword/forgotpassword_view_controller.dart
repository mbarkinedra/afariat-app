import 'package:afariat/model/filter.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:afariat/networking/api/forgotpassword_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewController extends GetxController {
  TextEditingController password = TextEditingController();
  ForgotPasswordApi _forgotPasswordApi = ForgotPasswordApi();
  ServerValidator validateServer = ServerValidator();

  forgotPassword() {
    Filter.data["username"] = password.text;
    _forgotPasswordApi.post(Filter.data).then((value) {
      validateServer.validateServer(
        success: () {},
        value: value,
      );
      Get.snackbar("message", value.data["message"]);
    }).catchError((error) {});
  }
}
