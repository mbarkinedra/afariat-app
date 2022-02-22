import 'package:flutter/material.dart';

class Validator {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String validatetitle(String value) {
    if (value.length < 11) {
      return "  Le titre doit faire au minimum 10 caractères";
    }

    return null;
  }

  String validatePrice(String value) {
    if (value.length < 1) {
      return "Le prix n'est pas valide";
    }

    return null;
  }

  String validateDescription(String value) {
    if (value.length < 20) {
      return " La description doit faire au moins 20 caractères.";
    }

    return null;
  }

  isvala() {
    final isv = globalKey.currentState.validate();
    print(isv);
  }
}
