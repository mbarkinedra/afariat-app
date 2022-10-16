import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form_validator.dart';

class ValidatorPassword {
  bool validationType = false;
  FormValidator formValidator = FormValidator();

  String validateCurrentPassword(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir votre mot de passe actuel";
      }
    } else {
      return formValidator.validate(value, 'currentPassword');
    }

    return null;
  }

  String validatePlainPassword(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir le nouveau mot de passe";
      }
      if (value.length < 6) {
        return "Le nouveau mot de passe doit faire au min 6 lettres";
      }
    } else {
      //server
      return formValidator.validate(value, 'plainPassword');
    }
    return null;
  }
}
