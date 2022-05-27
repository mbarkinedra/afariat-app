import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/validator/validate_server.dart';
import 'package:afariat/networking/api/user_api.dart';
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
  UserJson _userJson = UserJson();
  Wsse wsse = Wsse();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  updateUserData() {
    updateData = true;
    update();
    Filter.data["type"] = _userJson.type;
    Filter.data["email"] = email.text;

    Filter.data["name"] = name.text;
    Filter.data["phone"] = phone.text;

    Filter.data["city"] = localisation.city.id;

    _userApi.id = Get.find<AccountInfoStorage>().readUserId();

    _userApi.putData(dataToPost: Filter.data).then(
      (value) {

Get.find<AccountInfoStorage>().saveName(name.text);
        validateServer.validateServer(
            success: () {
              Get.snackbar("", "mise à jours avec succés ");
              updateData = false;
              wsse.generateWsseFromStorage();
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
    String userId = Get.find<AccountInfoStorage>().readUserId();

    _userApi.id = userId;
    name.text = _storage.readName() ?? "";
    email.text = _storage.readEmail() ?? "";
    phone.text = _storage.readPhone() ?? "";

    _userApi.secureGet().then((value) {
      _userJson = UserJson.fromJson(value.data);
      name.text = _userJson.name;

      phone.text = _userJson.phone;
      Get.find<AccountInfoStorage>().saveName(_userJson.name);
      Get.find<TapHomeViewController>().setUserName(_userJson.name);

      localisation.cities.forEach((element) {
        if (element.id == _userJson.city.id) {
          localisation.updateCity(element);
          update();
        }
      });
      _userApi.id = null;

    });
  }
}
