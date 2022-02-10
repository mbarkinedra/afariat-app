import 'package:afariat/config/filter.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/model/validate_server.dart';
import 'package:afariat/networking/api/forgotpassword_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewController extends GetxController {
  TextEditingController password = TextEditingController();
  ForgotPasswordApi _forgotPasswordApi = ForgotPasswordApi();
  ValidateServer validateServer = ValidateServer();

  forgotPassword() {
    Filter.data["username"] = password.text;
    _forgotPasswordApi.post(Filter.data).then((value) {
      validateServer.validatorServer(
        validate: () {},
        value: value,
      );
      Get.snackbar("message", value.data["message"]);
      print(value);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
