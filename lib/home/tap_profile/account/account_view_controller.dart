import 'package:afariat/networking/api/user.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:afariat/networking/api/abstract_user_api.dart';
import 'package:afariat/networking/json/user_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountViewController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  final localisation = Get.find<LocController>();
  bool updateData = false;

  ServerValidator validateServer = ServerValidator();
  AccountInfoStorage _storage = AccountInfoStorage();
  UserApi _userApi = UserApi();
  UserJson user = UserJson();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  updateUserData() {
    updateData = true;
    user.type = user.type;
    user.email = email.text;
    user.name = name.text;
    user.phone = phone.text;
    user.city.id = localisation.city.id;

    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    print(user.toJson(form: true)); //user.toJson(form: true)
    _userApi.putData(dataToPost: user.toJson(form: true)).then(
      (value) {
        Get.find<AccountInfoStorage>().saveName(user.name);
        validateServer.validateServer(
            success: () {
              Get.snackbar("", "Mise à jours avec succès ");
              updateData = false;
              Wsse.generateWsseFromStorage();
              update();
            },
            value: value);
      },
    ).catchError((e) {
      updateData = false;
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
