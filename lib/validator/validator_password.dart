import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import '../networking/api/abstract_user_api.dart';
import '../networking/json/simple_json_resource.dart';
import '../networking/security/wsse.dart';
import '../storage/AccountInfoStorage.dart';
import 'form_validator.dart';

class ValidatorPassword {
  bool validationType = false;
  FormValidator formValidator = FormValidator();
  UserApi _userApi = UserApi();

  String validateCurrentPassword(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir votre mot de passe actuel";
      }
    } else {
      return formValidator.validate(value, 'currentPassword');
    }

    return null;
  }

  String validatePlainPassword(String value) {
    if (!validationType) {
      if (value.isEmpty) {
        return "Veuillez saisir le nouveau mot de passe";
      }
      if (value.length < 6) {
        return "Le nouveau mot de passe doit faire au min 6 lettres";
      }
    } else {
      //server
      return formValidator.validate(value, 'plainPassword');
    }
    return null;
  }

  Future<String> validateRegistredPassword(String value) async {
    if (value.isEmpty) {
      return "Veuillez saisir le nouveau mot de passe";
    }

    AccountInfoStorage _accountInfoStorage = Get.find<AccountInfoStorage>();
    String username = _accountInfoStorage.readEmail();
    DIO.Response<dynamic> response = await _userApi.getSalt(username);

    SimpleJsonResource json = SimpleJsonResource.fromJson(response.data);
    if (json.code != 200) {
      //user not found.
      await _accountInfoStorage.logout();
      return 'Un problème est survenu. Vous êtes déconnecté. Veuillez vous reconnecter.';
    } else {
      String hashedPassword =
          Wsse.hashPassword(value, json.message); // compare the passwords
      if (hashedPassword != _accountInfoStorage.readHashedPassword()) {
        return 'Mot de passe invalide';
      }
    }

    return null;
  }
}
