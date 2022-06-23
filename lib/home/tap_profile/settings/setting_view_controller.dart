import 'package:afariat/networking/api/user.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:afariat/networking/api/abstract_password_api.dart';
import 'package:afariat/networking/api/abstract_user_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_view_controller.dart';

class SettingViewController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  bool updatePasseword = false;
  bool isVisiblePassword1 = true;
  bool isVisiblePassword2 = true;
  bool tham = false;
  ChangePasswordApi changePasswordApi = ChangePasswordApi();
  ServerValidator validateServer = ServerValidator();
  GetSaltApi _getSalt = GetSaltApi();
  AccountInfoStorage accountInfoStorage = AccountInfoStorage();
  UserApi _userApi = UserApi();
  ParameterBag userData = ParameterBag();

  void showHidePassword1() {
    isVisiblePassword1 = !isVisiblePassword1;

    update();
  }

  void showHidePassword2() {
    isVisiblePassword2 = !isVisiblePassword2;

    update();
  }

  changePassword() {
    updatePasseword = true;
    update();
    userData.data = {
      "currentPassword": oldPassword.text.toString(),
      "plainPassword": newPassword.text.toString(),
    };

    changePasswordApi.putData(dataToPost: userData.data).then((value) {
      if (value == null) {
        //a 500 error perhaps. No need to continue validating the server response
        return;
      }
      validateServer.validateServer(
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
            updatePasseword = false;
            update();
          });
          Get.snackbar("", value.data);
        },
        value: value,
      );
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
