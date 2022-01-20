import 'package:afariat/config/storage.dart';
import 'package:afariat/networking/api/user_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingViewController extends GetxController {
  TextEditingController password = TextEditingController();
  bool tham = false;

  UserApi _userApi = UserApi();

  deluser() {
    _userApi.id = password.text;
    _userApi.deleteUser().then((value) {
      print(value.data);
    });
  }
}
