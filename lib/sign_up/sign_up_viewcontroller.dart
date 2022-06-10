import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/model/user.dart';
import 'package:afariat/networking/api/user.dart';
import 'package:afariat/validator/validator_signUp.dart';
import 'package:afariat/networking/api/abstract_user_api.dart';
import 'package:afariat/sign_up/sign_up_succes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  final cityDropDown = Get.find<LocController>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  ValidatorSignUp validator = ValidatorSignUp();
  UserApi _signUpApi = UserApi();
  bool isVisiblePassword = true;
  List<TypeRegister> typeList = [
    TypeRegister(name: "Particulier", id: 0),
    TypeRegister(name: "Professionnel", id: 1)
  ];
  TypeRegister type;

  void showHidePassword() {
    isVisiblePassword = !isVisiblePassword;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    type = typeList[0];
  }

  updateTypeRegister(TypeRegister t) {
    type = t;
    update();
  }

  postRegister(context) async {
    User user = User(
        type: type?.id,
        first: password?.text,
        second: password?.text,
        phone: phone?.text,
        city: cityDropDown.city.id,
        name: name.text,
        email: email.text);

    await _signUpApi.postResource(user).then((value) {
      if (value == null) {
        //a 500 error perhaps. No need to continue validating the server response
        return;
      }
      validator.validatorServer.validateServer(
          value: value,
          success: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpSucces(value.data['message'])),
            );
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
          });
    }).catchError((e) {
      Get.snackbar("Erreur", "Oups ! une erreur s'est produite.");
    });
  }
}
