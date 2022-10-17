import 'package:afariat/config/app_routing.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../networking/api/abstract_user_api.dart';
import '../../../networking/json/post_json_response.dart';
import '../../../persistent_tab_manager.dart';
import '../../../validator/validator_password.dart';

class DeleteAccountViewController extends GetxController {
  TextEditingController password = TextEditingController();
  ValidatorPassword validator = ValidatorPassword();
  RxBool isVisiblePassword = false.obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  final UserApi _userApi = UserApi();

  AccountInfoStorage accountInfoStorage = AccountInfoStorage();

  deleteUser(BuildContext context) async {
    if (!accountInfoStorage.isLoggedIn()) {
      // be sure that user is logged in before making request
      PersistentTabManager.goToLoginPage(context);
    }

    isLoading.value = true;
    error.value = 'Validation...';
    String errorMsg = await validator.validateRegistredPassword(password.text);
    if (errorMsg != null) {
      // invalid.
      error.value = errorMsg;
      return;
    }

    //here we continue by making a delete call
    error.value = 'Suppression de compte..';
    int userId = int.parse(accountInfoStorage.readUserId());
    PostJsonResponse jsonResponse = await _userApi.deleteUserById(userId);
    print(jsonResponse.toJson());
    if (jsonResponse == null) {
      //probably it's a 500 error. TODO: FIX this in api_manager
      return;
    }

    if (jsonResponse.hasErrors() &&
        jsonResponse.errors.globalErrors.isNotEmpty) {
      error.value = jsonResponse.errors.globalErrors.first;
      return;
    }

    validator.formValidator.validateServer(
      postJsonResponse: jsonResponse,
      success: () {
        //delete success. Show the success delete page
        Get.toNamed(AppRouting.deleteAccountSuccess);
      },
      failure: () {
        error.value = jsonResponse.message;
      },
      notFound: () {
        error.value = jsonResponse.message;
      },
    );

    isLoading.value = false;
  }

  void togglePassword() {
    isVisiblePassword.value = !isVisiblePassword.value;

    update();
  }
}
