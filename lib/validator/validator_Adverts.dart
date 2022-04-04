import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidatorAdverts {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validationType = false;

  String validateTitle(String value) {
    if (!validationType) if (value.isEmpty) {
      return "Veuillez saisir le titre";
    }

    if (value.length < 10) {
      return "  Le titre doit faire au minimum 10 caractères";
    }
    validationType = true;
    return null;
  }

  String validatePrice(String value) {
    if (value.isEmpty) return " Veuillez renseigner le prix.";
    if (int.tryParse(value) < 0) return "Le prix doit être supérieur à 0 ";

    return null;
  }

  String validateSurface(String value) {
    print('je suis ici');
    if (value.isEmpty) {
      print('I m empty :)');
      return " Veuillez renseigner la surface.";
    }
    if (int.tryParse(value) < 1) {
      print('I m < 1 :)');
      return "La surface doit être supérieure à 0 ";
    }

    print('nothing');

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
