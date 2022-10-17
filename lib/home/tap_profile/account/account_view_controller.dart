import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/remote_widget/city_dropdown_viewcontroller.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/networking/json/user_json.dart';
import 'package:afariat/validator/validator_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../networking/api/abstract_user_api.dart';
import '../../../networking/json/post_json_response.dart';
import '../../../networking/json/simple_json_resource.dart';

class AccountViewController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  CityDropdownViewController cityDropdownViewController =
      CityDropdownViewController();
  RxBool isPro = false.obs;

  RxBool isLoading = false.obs;
  RxBool success = false.obs;

  ValidatorProfile validator = ValidatorProfile();

  AccountInfoStorage _storage = AccountInfoStorage();

  UserApi _userApi = UserApi();
  UserJson user = UserJson();

  RxString error = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadDataFromStorage();
    _updateUser();
    await getUserData();
  }

  loadDataFromStorage() async {
    user = await _storage.readUser();
  }

  _updateUser() {
    if (user != null) {
      firstName.text = user.firstName;
      lastName.text = user.lastName;
      email.text = user.email;
      phone.text = user.phone;
      if (user.city != null) {
        cityDropdownViewController.selectedItem =
            RefJson(id: user.city.id, name: user.city.name);
      }
    }
  }

  save() async {
    success.value = false;
    isLoading.value = true;
    user.type = isPro.isTrue ? 1 : 0;
    user.email = email.text;
    user.firstName = firstName.text;
    user.lastName = lastName.text;
    user.phone = phone.text;
    user.city.id = cityDropdownViewController.selectedItem.id;

    PostJsonResponse jsonResponse = await _userApi.update(user);
    if (jsonResponse == null) {
      //probably it's a 500 error. TODO: FIX this in api_manager
      error.value =
          'Ousp ! une erreur inattendue. Veuillez mettre à jour l\'application.';
      return;
    }

    if (jsonResponse.hasErrors() &&
        jsonResponse.errors.globalErrors.isNotEmpty) {
      error.value = jsonResponse.errors.globalErrors.first;
    }

    validator.formValidator.validateServer(
        postJsonResponse: jsonResponse,
        success: () {
          success.value = true;
        },
        failure: () {
          //validate server errors and show them in the form
          registerFormKey.currentState.validate();
        });

    isLoading.value = false;
  }

  getUserData() async {
    isLoading.value = true;
    try {
      int id = int.parse(_storage.readUserId());
      SimpleJsonResource jsonResource = await _userApi.getUser(id);
      isLoading.value = false;
      if (jsonResource == null) {
        //probably it's a 500 error. TODO: FIX this in api_manager
        error.value =
            'Un problème est survenue lors de la récupération de vos données.';
        return;
      }

      if (jsonResource.code != 200) {
        error.value = jsonResource.message;
        return;
      }
      user = UserJson.fromJson(jsonResource.message);

      if (user != null) {
        await _storage.saveUser(user);
      }

      _updateUser();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isLoading.value = false;
  }
}
