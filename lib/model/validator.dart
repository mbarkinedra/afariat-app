import 'package:flutter/material.dart';

class Validator {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String validatetitle(String value) {
    if (value.length < 11) {
      return " le titre doit avoir au minimum X caractères";
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
    if (value.length < 50) {
      return "La description doit faire au moins 50 caractères";
    }

    return null;
  }

  isvala() {
    final isv = globalKey.currentState.validate();
    print(isv);
  }
}
