import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/controllers/loc_controller.dart';
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
  final localisation = Get.find<LocController>();
  AccountInfoStorage _storage = AccountInfoStorage();
  UserApi _userApi = UserApi();
  UserJson _userJson = UserJson();

  @override
  void onInit() {
    super.onInit();
    getuserdata();
    name.text = _storage.readName() ?? "";
    email.text = _storage.readEmail() ?? "";
    phone.text = _storage.readPhone() ?? "";
  }
updateUserData(){
  // "email": "test@test.com",
  // "username": "test@test.com",
  // "name": "kika",
  // "type": 0,
  // "phone": "22923568",
  // "city": 1_userJson
  Filter.data["type"]= _userJson.type;
  Filter.data["email"]= email.text;
  Filter.data["username"]= _userJson.username;

  Filter.data["name"]= name.text;
  Filter.data["phone"]= phone.text;

  Filter.data["city"]=  localisation.citie;

  _userApi.putData(dataToPost: Filter.data).then((value) {
    print(value);
  });
}
  getuserdata() {
    String userid = Get.find<AccountInfoStorage>().readUserId();

    _userApi.id = userid;

    print(_userApi.id);
    _userApi.secureGet().then((value) {
      _userJson = UserJson.fromJson(value.data);
      name.text = _userJson.name;

      phone.text = _userJson.phone;
// city.text =_userJson.city.name;

      localisation.cities.forEach((element) {
        if (element.id == _userJson.city.id) {
          localisation.updatecitie(element);
        }
      });

      update();
    });
  }
}
