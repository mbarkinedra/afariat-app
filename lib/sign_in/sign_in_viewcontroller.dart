import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/home/home_view_controller.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:afariat/networking/api/sign_in_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignInViewController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GetSaltApi _getSalt = GetSaltApi();
  SignInApi _signInApi = SignInApi();

  login() {
    //GET the user SALT
    _getSalt.post({"login": "${email.text}"}).then((value) {
      String hashedPassword =
          Wsse.hashPassword(password.text, value.data["salt"]);
      print("Hashed Password: $hashedPassword");
      String wsse = Wsse.generateWsseHeader(email.text, hashedPassword);
      print("WSSE: $wsse");

      //Try to login user
      _signInApi.get({'X-WSSE': wsse}).then((value) {
        print("User ID: ${value.data["user_id"]}");
        //save user info to local storage

        AccountInfoStorage.saveEmail(email.text);
        AccountInfoStorage.saveHashedPassword(hashedPassword);
        AccountInfoStorage.saveUserId(value.data["user_id"].toString());

        Get.find<HomeViwController>().changeSelectedValue(0);

        //TODO: Process error cases: bad salt, bad login/pwd
      });
    });
  }
}
