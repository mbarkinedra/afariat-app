import 'package:afariat/home/tap_home/favorite/favorite_viewController.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/networking/security/wsse.dart';
import 'package:afariat/home/home_view_controller.dart';
import 'package:afariat/home/tap_profile/account/account_view_controller.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:afariat/networking/api/sign_in_api.dart';
import 'package:afariat/validator/validator_signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SignInViewController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GetSaltApi _getSalt = GetSaltApi();
  SignInApi _signInApi = SignInApi();
  bool isVisiblePassword = true;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  bool buttonLogin = false;
  ValidatorSignIn validator = ValidatorSignIn();

  void showHidePassword() {
    isVisiblePassword = !isVisiblePassword;
    update();
  }

  login() async {
    //GET the user
    buttonLogin = true;
    update();
    await _getSalt.post({"login": "${email.text}"}).then((value) {
      if(value == null){ //a 500 error perhaps. No need to continue validating the server response
        return ;
      }
      validator.validatorServer.validateServer(
          success: () {
            String hashedPassword =
                Wsse.hashPassword(password.text, value.data["salt"]);
            Get.find<AccountInfoStorage>().saveEmail(email.text);
            Get.find<AccountInfoStorage>().saveHashedPassword(hashedPassword);
            //Try to login user
            _signInApi.getData().then((value) {
              validator.validatorServer.validateServer(
                  value: value,
                  success: () async {
                    //save user info to local storage

                    await Get.find<FavoriteViewController>().getFavorite();

                    Get.find<AccountInfoStorage>()
                        .saveUserId(value.data["user_id"].toString());

                    Get.find<HomeViewController>().changeItemFilter(0);
                    Get.find<HomeViewController>().updateList();
                    Get.find<HomeViewController>().controller =
                        PersistentTabController(initialIndex: 0);
                    Get.find<AccountViewController>().getUserData();
                    email.clear();
                    password.clear();
                  },
                  authFailure: () {
                    Get.snackbar("Erreur", "Login ou mot de passe incorrect");
                  });
            }).catchError((e) {
              Get.snackbar("Erreur", "Votre password est incorrect");
            });
          },
          value: value,
          notFound: () {
            Get.snackbar("Erreur", "Utilisateur introuvable");
          });
    }).catchError((e) {
      Get.snackbar("Erreur", "Oups ! une erreur s'est produite.");
    });
    buttonLogin = false;
    update();
  }
}
