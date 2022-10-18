import 'package:get/get.dart';

import 'form_validator.dart';

class ValidatorSignUp {
  bool validationType = false;
  FormValidator formValidator = FormValidator();

  String validateFirstName(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir votre prénom ou le nom de votre société";
      }
    } else {
      formValidator.validate(value, 'firstName');
    }

    return null;
  }
  
  String validateLastName(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir votre nom";
      }
    } else {
      formValidator.validate(value, 'lastName');
    }

    return null;
  }

  String validatePhone(String value) {
    if (!validationType) {
      if (value.isEmpty || value.length < 8) {
        return "Veuillez saisir votre numero de téléphone";
      }
    } else {
      //server
      return formValidator.validate(value, 'phone');
    }
    return null;
  }

  String validateEmail(String value) {
    if (!validationType) {
      //client
      if (!GetUtils.isEmail(value)) {
        return "Veuillez saisir votre email";
      }
    } else {
      //server
      return formValidator.validate(value, 'email');
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty || value.length < 6) {
      return "Veuillez saisir  votre mot de passe";
    }

    return null;
  }

  String validateCity(object) {
    if (object == null) {
      return " La ville est obligatoire";
    }
    return null;
  }
}
