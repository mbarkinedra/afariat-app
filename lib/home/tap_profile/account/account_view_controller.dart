import 'package:afariat/networking/api/user.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
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
  TextEditingController city = TextEditingController();
  final localisation = Get.find<LocController>();
  bool updateData = false;

  ValidatorProfile validator = ValidatorProfile();

  AccountInfoStorage _storage = AccountInfoStorage();
  UserApi _userApi = UserApi();
  UserJson user = UserJson();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  updateUserData() async {
    updateData = true;
    update();
    user.type = user.type;
    user.email = email.text;
    user.name = name.text;
    user.phone = phone.text;
    user.city.id = localisation.city.id;

    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    await _userApi.putResource(dataToPost: user.toJson(form: true)).then(
      (value) {
        print(value);
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
      print(e);
      Get.snackbar(
        'Oups !',
        'Une erreur s\'est produite. Veuillez relancer l\'appli ou la mettre à jour.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );

      update();
    });
  }

  getUserData() {
    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    name.text = _storage.readName() ?? "";
    email.text = _storage.readEmail() ?? "";
    phone.text = _storage.readPhone() ?? "";

    _userApi.secureGet().then((value) {
      user = UserJson.fromJson(value.data);
      name.text = user.name;
      phone.text = user.phone;
      email.text = user.email;
      Get.find<AccountInfoStorage>().saveName(user.name);
      Get.find<TapHomeViewController>().setUserName(user.username);

      localisation.cities.forEach((element) {
        if (element.id == user.city.id) {
          localisation.updateCity(element);
          update();
        }
      });
      //_userApi.id = null;
    });
  }
}
