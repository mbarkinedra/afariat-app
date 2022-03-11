import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validator {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String validatetitle(String value) {
    if (value.isNotEmpty) {
      if (value.length < 11) {
        return "  Le titre doit faire au minimum 10 caractères";
      }
    } else if (value.isEmpty) {
      return "Veuillez saisir le titre";
    }
    return null;
  }

  String validatePrice(String value) {
    if (value.isEmpty) {
      return " Veuillez renseigner le prix.";
    } else if (int.tryParse(value) < 0) {
      return "Le prix doit être supérieur ou égale à 0 ";
    }
    return null;
  }

  String validateMarque(String value) {
    if (value.isEmpty) {
      return " Veuillez renseigner le prix.";
    }
    return null;
  }

  String validateSurface(String value) {
    if (value.isEmpty) {
      return " Veuillez renseigner le prix.";
    } else if (int.tryParse(value) < 0) {
      return "La superficie doit être positive  ";
    }
    return null;
  }

  String validateDescription(String value) {
    if (value.isNotEmpty) {
      if (value.length < 20) {
        return " La description doit faire au moins 20 caractères.";
      }
    } else if (value.isEmpty) {
      return "Veuillez renseigner la description";
    }

    return null;
  }

  isvala() {
    globalKey.currentState.validate();
  }

  String validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "9çççççççççççççççççççççççççççççççççççççççççççç";
    }
    return null;
  }


}
