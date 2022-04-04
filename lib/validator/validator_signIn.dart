import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidatorSignIn {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validationType = false;
  ServerValidator validatorServer = ServerValidator();

  String validateEmail(String value) {
    if (!validationType) {
      if (!GetUtils.isEmail(value)) {
        return "Veuillez saisir votre email";
      }
    } else {
      return validatorServer.validate(value, 'email');
    }
    return null;
  }

  String validatePassword(String value) {
    if (!validationType) {
      if (value.isEmpty || value.length < 5) {
        return "Veuillez saisir  votre mot de passe";
      }
    } else {
      return validatorServer.validate(value, "password");
    }
    return null;
  }
}
