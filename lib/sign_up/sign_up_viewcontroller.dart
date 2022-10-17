import 'package:afariat/config/app_routing.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/model/user.dart';
import 'package:afariat/validator/validator_signUp.dart';
import 'package:afariat/networking/api/abstract_user_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../networking/json/post_json_response.dart';
import '../remote_widget/city_dropdown_viewcontroller.dart';
import '../sign_in/sign_in_viewcontroller.dart';

class SignUpViewController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  CityDropdownViewController cityDropdownViewController =
      CityDropdownViewController();
  ValidatorSignUp validator = ValidatorSignUp();
  final UserApi _userApi = UserApi();
  bool isVisiblePassword = true;
  List<TypeRegister> typeList = [
    TypeRegister(name: "Particulier", id: 0),
    TypeRegister(name: "Professionnel", id: 1)
  ];
  TypeRegister type;

  RxBool isLoading = false.obs;
  RxString globalErrors = ''.obs;

  void showHidePassword() {
    isVisiblePassword = !isVisiblePassword;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    type = typeList[0];
    isLoading.value = false;
  }

  updateTypeRegister(TypeRegister t) {
    type = t;
    update();
  }

  postRegister(context) async {
    isLoading.value = true;
    globalErrors.value = '';
    User user = User(
      type: type?.id,
      first: password?.text,
      second: password?.text,
      phone: phone?.text,
      city: cityDropdownViewController.selectedItem.id,
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
    );

    try {
      PostJsonResponse jsonResponse = await _userApi.register(user);
      if (jsonResponse == null) {
        //probably it's a 500 error. TODO: FIX this in api_manager
        return;
      }

      if (jsonResponse.hasErrors() &&
          jsonResponse.errors.globalErrors.isNotEmpty) {
        globalErrors.value = jsonResponse.errors.globalErrors.first;
      }

      validator.formValidator.validateServer(
          postJsonResponse: jsonResponse,
          success: () {
            Get.toNamed(
              AppRouting.signUpSuccess,
              parameters: {'message': jsonResponse.message},
            );

            //set the email/password in the login controller.
            Get.find<SignInViewController>().emailController.val(email.text);
            Get.find<SignInViewController>().passwordController.val(password.text);
          },
          failure: () {
            //validate server errors and show them in the form
            registerFormKey.currentState.validate();
          });
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e);
        throw e;
      }
    }
    isLoading.value = false;
  }
}
