
import 'package:afariat/config/storage.dart';
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
  final storge=Get.find<SecureStorage>();
  GetSaltApi _getSalt = GetSaltApi();
  SignInApi _signInApi = SignInApi();

  getwsse() {
    _getSalt.post({"login": "${email.text}"}).then((value) {
   value.data["salt"];
      storge.writeSecureData( storge.key_password, password.text);
      String hashedPassword = hashPassword(password.text, value.data["salt"]);
      print(hashedPassword);
      String wsse = generateWsseHeader(email.text, hashedPassword);
      print(wsse);
      storge.writeSecureData( storge.key_hashPassword, hashedPassword);
      storge.writeSecureData( storge.key_email, email.text);
      storge.writeSecureData( storge.key_wsse,wsse);
      _signInApi.get({'X-WSSE': wsse}).then((value) {
        print(value.data);
        print(value.data["user_id"]);
        storge.writeSecureData( storge.user_id, value.data["user_id"].toString());
        Get.find<HomeViwController>().changeSelectedValue(0);
      });
    });
  }


}
