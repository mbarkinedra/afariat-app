import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/home/tap_profile/account/account_view_controller.dart';
import 'package:afariat/networking/api/abstract_user_api.dart';
import 'package:afariat/validator/validator_signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../config/app_routing.dart';
import '../home/main_view_controller.dart';
import '../networking/json/simple_json_resource.dart';
import '../persistent_tab_manager.dart';

class SignInViewController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final UserApi _userApi = UserApi();
  bool isVisiblePassword = true;
  GlobalKey<FormState> signInFormKey;
  RxBool isLoading = false.obs;
  ValidatorSignIn validator = ValidatorSignIn();

  RxString error = ''.obs;

  void showHidePassword() {
    isVisiblePassword = !isVisiblePassword;
    update();
  }

  login() async {
    error.value = '';
    isLoading.value = true;
    try {
      SimpleJsonResource jsonResource =
          await _userApi.login(emailController.text, passwordController.text);
      isLoading.value = false;
      if (jsonResource != null) {
        if (jsonResource.code == 200) {
          Get.toNamed(AppRouting.loginSuccess);
        } else {
          error.value = jsonResource.message;
        }
      }
    } catch (e) {
      isLoading.value = false;
      throw e;
    }
  }
}
