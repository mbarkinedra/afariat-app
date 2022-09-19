import 'package:afariat/networking/api/user.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:afariat/networking/api/abstract_password_api.dart';
import 'package:afariat/networking/api/abstract_user_api.dart';
import 'package:afariat/validator/validator_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_view_controller.dart';

class SettingViewController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  bool updateData = false;
  bool isVisiblePassword1 = true;
  bool isVisiblePassword2 = true;
  bool tham = false;
  ChangePasswordApi changePasswordApi = ChangePasswordApi();
  ValidatorPassword validator = ValidatorPassword();
  final GetSaltApi _getSalt = GetSaltApi();
  AccountInfoStorage accountInfoStorage = AccountInfoStorage();
  final UserApi _userApi = UserApi();
  ParameterBag userData = ParameterBag();

  void showHidePassword1() {
    isVisiblePassword1 = !isVisiblePassword1;

    update();
  }

  void showHidePassword2() {
    isVisiblePassword2 = !isVisiblePassword2;

    update();
  }

  changePassword() async {
    updateData = true;
    update();
    userData.data = {
      "currentPassword": oldPassword.text.toString(),
      "plainPassword": newPassword.text.toString(),
    };

    await changePasswordApi.putData(dataToPost: userData.data).then((value) {
      updateData = false;
      if (value == null) {
        //a 500 error perhaps. No need to continue validating the server response
        return;
      }
      validator.validatorServer.validateServer(
          value: value,
          success: () {
            _getSalt.post({"login": "${accountInfoStorage.readEmail()}"}).then(
                (value) {
              String hashedPassword =
                  Wsse.hashPassword(newPassword.text, value.data["salt"]);
              Wsse.generateWsseHeader(
                  accountInfoStorage.readEmail(), hashedPassword);

              Get.find<AccountInfoStorage>()
                  .saveEmail(accountInfoStorage.readEmail());
              Get.find<AccountInfoStorage>().saveHashedPassword(hashedPassword);
              registerFormKey.currentState.reset();
              update();
            });
            Get.snackbar("Succès", value.data,
                colorText: Colors.black87,
                backgroundColor: Colors.greenAccent,
                icon: const Icon(Icons.check_circle));
          },
          failure: () {
            //validate server errors and show them in the form
            registerFormKey.currentState.validate();
            Get.snackbar(
              'Erreur',
              'Veuillez corriger les erreurs ci-dessous.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
            update();
          });
    });
  }

  deleteUser() {
    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    _userApi
        .deleteResource(Get.find<AccountInfoStorage>().readUserId())
        .then((value) {
      Get.find<AccountInfoStorage>().logout();
      Get.find<HomeViewController>().changeItemFilter(0);
      Get.back();
    });
  }
}
