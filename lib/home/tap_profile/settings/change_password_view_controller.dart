import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/validator/validator_password.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../networking/api/abstract_user_api.dart';
import '../../../networking/json/post_json_response.dart';
import '../../../persistent_tab_manager.dart';

class ChangePasswordViewController extends GetxController {
  final changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController plainPassword = TextEditingController();

  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxString success = ''.obs;

  bool isVisiblePassword1 = true;
  bool isVisiblePassword2 = true;
  final UserApi _userApi = UserApi();
  ValidatorPassword validator = ValidatorPassword();
  AccountInfoStorage accountInfoStorage = AccountInfoStorage();

  //final UserApi _userApi = UserApi();
  ParameterBag userData = ParameterBag();

  void showHidePassword1() {
    isVisiblePassword1 = !isVisiblePassword1;

    update();
  }

  void showHidePassword2() {
    isVisiblePassword2 = !isVisiblePassword2;

    update();
  }

  changePassword(BuildContext context) async {
    if (!accountInfoStorage.isLoggedIn()) {
      // be sure that user is logged in before making request
      PersistentTabManager.goToLoginPage(context);
    }
    isLoading.value = true;
    try {
      PostJsonResponse jsonResponse = await _userApi.changePassword(
          currentPassword.text.toString(), plainPassword.text.toString());
      isLoading.value = false;

      if (jsonResponse == null) {
        //probably it's a 500 error. TODO: FIX this in api_manager
        return;
      }

      if (jsonResponse.hasErrors() &&
          jsonResponse.errors.globalErrors.isNotEmpty) {
        error.value = jsonResponse.errors.globalErrors.first;
      }

      validator.formValidator.validateServer(
          postJsonResponse: jsonResponse,
          success: () {
            success.value = jsonResponse.message;
            update();
          },
          failure: () {
            //validate server errors and show them in the form
            changePasswordFormKey.currentState.validate();
            success.value = '';
            update();
          });
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e);
        throw e;
      }
    }

    /*await changePasswordApi.putData(dataToPost: userData.data).then((value) {
      isSending = false;
      if (value == null) {
        //a 500 error perhaps. No need to continue validating the server response
        return;
      }
      validator.validatorServer.validateServer(
          value: value,
          success: () {
            _userApi.post({"login": "${accountInfoStorage.readEmail()}"}).then(
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
    });*/
  }

  deleteUser() {
    throw UnimplementedError;
    /*_userApi.id = Get.find<AccountInfoStorage>().readUserId();
    _userApi
        .deleteResource(Get.find<AccountInfoStorage>().readUserId())
        .then((value) {
      Get.find<AccountInfoStorage>().logout();
    //  Get.find<MainViewController>().changeItemFilter(0);
      Get.back();
    });*/
  }
}
