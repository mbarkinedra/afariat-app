import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/home/home_view_controller.dart';
import 'package:afariat/home/tap_profile/account/account_view_controller.dart';
import 'package:afariat/model/validate_server.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:afariat/networking/api/sign_in_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SignInViewController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final storge = Get.find<SecureStorage>();
  GetSaltApi _getSalt = GetSaltApi();
  SignInApi _signInApi = SignInApi();
  bool isVisiblePassword = true;
  ValidateServer validateServer = ValidateServer();
  final signInFormKey = GlobalKey<FormState>();
  String validEmail = "";
  bool buttonConnceter = false;

  String validateEmail(String value) {
    String val;
    if (true) {
      val = "Votre e_mail est incorrect";
    }

    return val;
  }

  void showHidePassword() {
    isVisiblePassword = !isVisiblePassword;


    update();
  }

  login()async {
    //GET the user
    buttonConnceter = true;
    update();
  await  _getSalt.post({"login": "${email.text}"}).then((value) {
      validateServer.validatorServer(
          validate: () {
            String hashedPassword =
                Wsse.hashPassword(password.text, value.data["salt"]);
            String wsse = Wsse.generateWsseHeader(email.text, hashedPassword);
            Get.find<AccountInfoStorage>().saveEmail(email.text);
            Get.find<AccountInfoStorage>().saveHashedPassword(hashedPassword);
            //Try to login user
            _signInApi.getdata({'X-WSSE': wsse}).then((value) {
              validateServer.validatorServer(
                  value: value,
                  validate: () {
                    //save user info to local storage

                    Get.find<AccountInfoStorage>()
                        .saveUserId(value.data["user_id"].toString());

                    Get.find<HomeViwController>().changeItemFilter(0);
                    Get.find<HomeViwController>().updatelist();
                    Get.find<HomeViwController>().controller =
                        PersistentTabController(initialIndex: 0);
            Get.find<AccountViewController>().getUserData();
                  email.clear();
                  password.clear();});
              //TODO: Process error cases: bad salt, bad login/pwd
            }).catchError((e) {
              Get.snackbar("Erreur", "Votre password est incorrect");
            });
             },
          value: value,
          registerFormKey: signInFormKey);

    }).catchError((e) {

      validEmail = email.text;
      validateEmail(validEmail);
      signInFormKey.currentState.validate();
      Get.snackbar("Erreur", "Votre e_mail est incorrect");
    });
    buttonConnceter = false;
    update();  }
}
