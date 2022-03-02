import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/model/validate_server.dart';
import 'package:afariat/networking/api/change_password_api.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingViewController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  bool updatepasseword = false;
  bool isVisiblePassword1 = true;
  bool isVisiblePassword2 = true;
  bool tham = false;
  ChangePasswordApi changePasswordApi = ChangePasswordApi();
  ValidateServer validateServer = ValidateServer();
  final storge = Get.find<SecureStorage>();
  GetSaltApi _getSalt = GetSaltApi();
  AccountInfoStorage accountInfoStorage = AccountInfoStorage();

  void showHidePassword1() {
    isVisiblePassword1 = !isVisiblePassword1;

    update();
  }

  void showHidePassword2() {
    isVisiblePassword2 = !isVisiblePassword2;

    update();
  }

  changePassword() {
    updatepasseword = true;
    update();
    Filter.data = {
      "currentPassword": oldPassword.text.toString(),
      "plainPassword": newPassword.text.toString(),
    };

    changePasswordApi.putData(dataToPost: Filter.data).then((value) {
      validateServer.validatorServer(
        validate: () {
          _getSalt.post({"login": "${accountInfoStorage.readEmail()}"}).then(
              (value) {
            String hashedPassword =
                Wsse.hashPassword(newPassword.text, value.data["salt"]);
            Wsse.generateWsseHeader(
                accountInfoStorage.readEmail(), hashedPassword);

            Get.find<AccountInfoStorage>()
                .saveEmail(accountInfoStorage.readEmail());
            Get.find<AccountInfoStorage>().saveHashedPassword(hashedPassword);
            updatepasseword = false;
            update();
          });
          Get.snackbar("", value.data);
        },
        value: value,
      );
    });
  }
}
