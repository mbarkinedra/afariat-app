import 'dart:convert';

import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/model/user.dart';
import 'package:afariat/networking/api/sign_up_api.dart';
import 'package:afariat/sign_up/sign_up_succes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  final tapHomeViewController = Get.find<LocController>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  bool isVisiblePassword = false;

  SignUpApi _signUpApi = SignUpApi();
  List<TypeRegister> typeList = [
    TypeRegister(name: "Particulier", id: 0),
    TypeRegister(name: "Professionnel", id: 1)
  ];
  TypeRegister type;

  Map<String, dynamic> serverErrors;

  /// value: is the entered user value, field: is the name of the field
  String validator(String value, String field) {
    //1st validate the front entered fields, then validate the errors from server
    //
    String errorMessage = null;
    //validating server errors
    serverErrors.forEach((key, elementErrors) {
      if (field == key && elementErrors.containsKey('errors')) {
        if (elementErrors['errors'].length > 0) {
          errorMessage = elementErrors['errors'][0];
        }
      }
    });

    return errorMessage ?? null;
  }

  void showHidePassword() {
    this.isVisiblePassword = !this.isVisiblePassword;
    print('pressed');

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

/*  validatorfun(String  v){
    if (v == null || v.isEmpty) {

      return 'Please enter some text';
    }
    return null;
  }*/
  postRegister(context) async {
    User user = User(
        type: type.id,
        first: password.text,
        second: password.text,
        phone: phone.text,
        city: tapHomeViewController.citie.id,
        name: name.text,
        email: email.text);

    var response = await _signUpApi.post(user).then((value) {
      print(value.statusCode);

      switch (value.statusCode) {
        case 201:
          //Affichage success
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpSucces(value.data['message'])),
          );
          break;
        case 400:
          serverErrors = value.data;
          value.data.forEach((key, value) {
            print('Key: $key');
            print('------------------------------');
          });
          registerFormKey.currentState.validate();

          //validator('email');
//           Error_Register errors= Error_Register.fromJson(  value.data);
//           print(errors);
// var a=value.data ;

          Get.snackbar(
            'Erreur',
            'Veuillez corriger les erreurs ci-dessous.',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
          break;
        default:
          return;
      }
      // Navigator.pushReplacement(
      //    context,
      //    MaterialPageRoute(builder: (context) => SignUpSucces()),
      //  );
    }).catchError((e) {
      // Error_Register errors= Error_Register.fromJson(  e);
      Get.snackbar("error", "${e}");
    });
    // print("response.statusCode ${response.statusCode}");
  }
}
