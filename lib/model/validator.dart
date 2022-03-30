import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validator {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String validateTitle(String value) {

      if (value.length < 11) {
        return "  Le titre doit faire au minimum 10 caractères";
      }else
  if (value.isEmpty) {
      return "Veuillez saisir le titre";
    }else{
    return null;
  }

  }

  String validatePrice(String value) {
    if (value.isEmpty) {
      return " Veuillez renseigner le prix.";
    } else if (int.tryParse(value) < 0) {
      return "Le prix doit être supérieur à 0 ";
    }
    return null;
  }

  String validateSurface(String value) {
    if (value.isEmpty || value == null) {
      return " Veuillez renseigner la surface.";
    } else if (int.tryParse(value).isNegative) {
      return "La surface doit être positive  ";
    }
    return null;
  }

  String validateDescription(String value) {

      if (value.length < 20) {
        return " La description doit faire au moins 20 caractères.";

    }
      if (value.isEmpty) {
      return "Veuillez renseigner la description";
    }

    return null;
  }

  isValid() {
    globalKey.currentState.validate();
  }

  String validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "email";
    }
    return null;
  }
}
