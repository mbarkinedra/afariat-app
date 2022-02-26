import 'package:flutter/material.dart';

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
    if (value.isNotEmpty) {
      if (double.parse(value) == 0) {
        return "Le prix doit être supérieur à 0 ";
      }
    } else if (value.isEmpty) {
      return " Veuillez renseigner le prix.";
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
    final isv = globalKey.currentState.validate();
    print(isv);
  }
}
