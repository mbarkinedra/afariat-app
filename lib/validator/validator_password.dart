import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidatorPassword {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validationType = false;
  ServerValidator validatorServer = ServerValidator();

  String validateCurrentPassword(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir votre mot de passe actuel";
      }
    } else {
      validatorServer.validate(value, 'currentPassword');
    }

    return null;
  }

  String validatePlainPassword(String value) {
    if (!validationType) {
      if (value.isEmpty || value.length < 8) {
        return "Veuillez saisir le nouveau mot de passe";
      }
    } else {
      //server
      return validatorServer.validate(value, 'plainPassword');
    }
    return null;
  }
}
