import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/validate_server.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:afariat/networking/api/sign_in_api.dart';
import 'package:afariat/networking/api/user_api.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/networking/json/user_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountViewController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  ValidateServer _validateServer = ValidateServer();
  final localisation = Get.find<LocController>();
  AccountInfoStorage _storage = AccountInfoStorage();
  UserApi _userApi = UserApi();
  UserJson _userJson = UserJson();
  ValidateServer validateServer = ValidateServer();
  bool updateData = false;
  GetSaltApi _getSalt = GetSaltApi();
  SignInApi _signInApi = SignInApi();
  Wsse wsse = Wsse();

  @override
  void onInit() {
    super.onInit();
    getuserdata();
  }

  updateUserData() {
    // "email": "test@test.com",
    // "username": "test@test.com",
    // "name": "kika",
    // "type": 0,
    // "phone": "22923568",
    // "city": 1_userJson
    updateData = true;
    update();
    Filter.data["type"] = _userJson.type;
    Filter.data["email"] = email.text;
    // Filter.data["username"] = _userJson.username;

    Filter.data["name"] = name.text;
    Filter.data["phone"] = phone.text;

    Filter.data["city"] = localisation.citie.id;

    _userApi.id = Get.find<AccountInfoStorage>().readUserId();
    print(_userApi.apiUrl());
    _userApi.putData(dataToPost: Filter.data).then(
      (value) {
        print(value.data);
        _validateServer.validatorServer(
            validate: () {
              Get.snackbar("", "mise à jours avec succés ");
              updateData = false;
              wsse.generateWsseFromStorage();
              update();
            },
            value: value);

        print(value.data);
      },
    ).catchError((e) {
      updateData = false;
      update();
      print(e.toString());
    });
  }

  getuserdata() {
    String userid = Get.find<AccountInfoStorage>().readUserId();

    _userApi.id = userid;
    name.text = _storage.readName() ?? "";
    email.text = _storage.readEmail() ?? "";
    phone.text = _storage.readPhone() ?? "";

    _userApi.secureGet().then((value) {
      _userJson = UserJson.fromJson(value.data);
      name.text = _userJson.name;

      phone.text = _userJson.phone;
      print(
          "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      print(_userJson.phone);
      print(_userJson.username);
      print(_userJson.city.id);
      print(_userJson.id);
      print(
          "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      localisation.cities.forEach((element) {
        if (element.id == _userJson.city.id) {
          localisation.updatecitie(element);
        }
      });
      _userApi.id = null;
      update();
    });
  }
}
