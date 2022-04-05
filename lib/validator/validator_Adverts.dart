import 'package:afariat/validator/validate_server.dart';
import 'package:flutter/material.dart';

class ValidatorAdverts {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validationType = false;
  ServerValidator validatorServer = ServerValidator();

  String validateTitle(String value) {
    if (!validationType) {
      if (value.isEmpty) return "Veuillez saisir le titre";

      if (value.length < 10)
        return "  Le titre doit faire au minimum 10 caractères";

      if (value.length > 65)
        return "  Le titre ne doit pas dépasser 65 caractères";
    } else {
      validatorServer.validate(value, 'title');
    }
    return null;
  }

  String validatePrice(String value) {
    if (!validationType) {
      if (value.isEmpty) return " Veuillez renseigner le prix.";

      int parsedValue = int.tryParse(value);
      if (parsedValue == null) return "Veuillez saisir un nombre";

      if (int.tryParse(value) < 0) return "Le prix doit être supérieur à 0 ";
    } else {
      validatorServer.validate(value, "price");
    }

    return null;
  }

  String validateSurface(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez renseigner la surface.";
      }
      int parsedValue = int.tryParse(value);
      if (parsedValue == null) return "Veuillez saisir un nombre";
      if (parsedValue < 1) return "La surface doit être supérieure à 0 ";
    } else {
      return validatorServer.validate(value, 'area');
    }
    return null;
  }

  String validateDescription(String value) {
    if (value.isEmpty) {
      return "Veuillez renseigner la description";
    }
    if (!validationType) {
      if (value.length < 20) {
        return " La description doit faire au moins 20 caractères.";
      }
    } else {
      validatorServer.validate(value, 'description');
    }
    return null;
  }

  String validateCity(object) {
    if (object == null) {
      return " La ville est obligatoire";
    }
    return null;
  }

  String validateTown(object) {
    if (object == null) {
      return " La commune est obligatoire";
    }
    return null;
  }

  String validateCategory(object) {
    if (object == null) {
      return " La category est obligatoire";
    }
    return null;
  }

  String validateSousCategory(object) {
    if (object == null) {
      return " La sous category est obligatoire";
    }
    return null;
  }

  String validateKm(object) {
    if (object == null) {
      return " Le kilometrage est obligatoire";
    }
    return null;
  }

  String validateYears(object) {
    if (object == null) {
      return " L'année est obligatoire";
    }
    return null;
  }

  String validateEnergie(object) {
    if (object == null) {
      return " L'energie est obligatoire";
    }
    return null;
  }

  String validateModele(object) {
    if (object == null) {
      return "Le modele est obligatoire";
    }
    return null;
  }

  String validateMarque(object) {
    if (object == null) {
      return "Le marque est obligatoire";
    }
    return null;
  }

  validatePieces(object) {
    if (object == null) {
      return " Nombre de pièces est obligatoire";
    }
    return null;
  }
}
