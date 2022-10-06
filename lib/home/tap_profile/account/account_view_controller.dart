import 'package:afariat/networking/api/user.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/remote_widget/city_dropdown_viewcontroller.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:afariat/networking/json/user_json.dart';
import 'package:afariat/validator/validator_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountViewController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  CityDropdownViewController cityDropdownViewController =
      CityDropdownViewController();
  bool updateData = false;

  ValidatorProfile validator = ValidatorProfile();

  AccountInfoStorage _storage = AccountInfoStorage();
  UserApi _userApi = UserApi();
  UserJson user = UserJson();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
  }

  updateUserData() async {
    updateData = true;
    update();
    user.type = user.type;
    user.email = email.text;
    user.name = name.text;
    user.phone = phone.text;
    user.city.id = cityDropdownViewController.selectedItem.id;

    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    await _userApi.putResource(dataToPost: user.toJson(form: true)).then(
      (value) {
        updateData = false;
        validator.validatorServer.validateServer(
            value: value,
            success: () {
              Get.snackbar("Succes", "Mise à jour avec succès",
                  colorText: Colors.black87,
                  backgroundColor: Colors.greenAccent,
                  icon: const Icon(Icons.check_circle));

              Get.find<AccountInfoStorage>().saveName(user.name);
              Wsse.generateWsseFromStorage();
              registerFormKey.currentState.reset();
              update();
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
      },
    ).catchError((e) {
      Get.snackbar(
        'Oups !',
        'Une erreur s\'est produite. Veuillez relancer l\'appli ou la mettre à jour.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );

      update();
    });
  }

  getUserData() async {
    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    name.text = _storage.readName() ?? "";
    email.text = _storage.readEmail() ?? "";
    phone.text = _storage.readPhone() ?? "";

    await _userApi.secureGet().then((value) {
      user = UserJson.fromJson(value.data);
      name.text = user.name;
      phone.text = user.phone;
      email.text = user.email;
      Get.find<AccountInfoStorage>().saveName(user.name);
      //Get.find<TapHomeViewController>().setUserName(user.username);
      cityDropdownViewController.selectedItem =
          RefJson(id: user.city.id, name: user.city.name);
      update();
      //_userApi.id = null;
    });
  }
}
