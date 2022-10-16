import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form_validator.dart';

class ValidatorSignIn {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validationType = false;
  FormValidator formValidator = FormValidator();

  String validateEmail(String value) {
    if (!validationType) {
      String email = value.trim();
      if (email.isEmpty) return "Veuillez saisir votre adresse email.";
      if (!GetUtils.isEmail(email)) {
        return "Veuillez saisir une adresse email valide";
      }
    } else {
      return formValidator.validate(value, 'email');
    }
    return null;
  }

  String validatePassword(String value) {
    if (!validationType) {
      if (value.isEmpty) return "Veuillez saisir  votre mot de passe";
      if (value.length < 6)
        return "Le mot de passe doit faire au min 6 caractères";
    } else {
      return formValidator.validate(value, "password");
    }
    return null;
  }
}
