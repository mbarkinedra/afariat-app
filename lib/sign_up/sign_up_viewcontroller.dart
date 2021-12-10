
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/model/user.dart';
import 'package:afariat/networking/api/sign_up_api.dart';
import 'package:afariat/sign_up/sign_up_succes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewController extends GetxController {
  final tapHomeViewController = Get.find<LocController>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();
  SignUpApi _signUpApi = SignUpApi();
  List<TypeRegister> typeList = [
    TypeRegister(name: "Particulier", id: 0),
    TypeRegister(name: "Professionnel", id: 1)
  ];
  TypeRegister type;

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
            MaterialPageRoute(builder: (context) => SignUpSucces()),
          );
          break;
        case 400:

//           print(value.data);
//           Error_Register errors= Error_Register.fromJson(  value.data);
//           print(errors);
// var a=value.data ;

          Get.snackbar("error", "${ value.data}");
          break;
        default:
          return;
      }
     // Navigator.pushReplacement(
     //    context,
     //    MaterialPageRoute(builder: (context) => SignUpSucces()),
     //  );
    }).catchError((e){


     // Error_Register errors= Error_Register.fromJson(  e);
      Get.snackbar("error", "${ e }");



    });
   // print("response.statusCode ${response.statusCode}");

  }
}
