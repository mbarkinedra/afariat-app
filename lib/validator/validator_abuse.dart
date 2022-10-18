import 'package:get/get.dart';

import 'form_validator.dart';

class ValidatorAbuse {
  bool validationType = false;
  FormValidator formValidator = FormValidator();

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

  String validateMessage(String value) {
    if (value.isEmpty) {
      return "Veuillez décrire brièvement le problème avec cette annonce";
    }

    if (value.length < 20)
      return "Votre message doit faire au minimum 20 caractères.";

    return null;
  }

  String validateCategory(object) {
    if (object == null) {
      return " Le motif est obligatoire";
    }
    return null;
  }
}
