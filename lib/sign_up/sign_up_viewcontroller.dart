import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/model/user.dart';
import 'package:afariat/model/validate_server.dart';
import 'package:afariat/networking/api/sign_up_api.dart';
import 'package:afariat/sign_up/sign_up_succes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewController extends GetxController {
 // final registerFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final tapHomeViewController = Get.find<LocController>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  ValidateServer validateServer = ValidateServer();
  bool isVisiblePassword = true;

  SignUpApi _signUpApi = SignUpApi();
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
        type: type.id,
        first: password.text,
        second: password.text,
        phone: phone.text,
        city: tapHomeViewController.city.id,
        name: name.text,
        email: email.text);

    await _signUpApi.post(user).then((value) {

      validateServer.validatorServer(
          validate: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpSucces(value.data['message'])),
            );
          },
          value: value,
          registerFormKey: registerFormKey);
    }).catchError((e) {
      Get.snackbar("Erreur", "$e");
    });
  }
}
