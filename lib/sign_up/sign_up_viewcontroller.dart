import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/user.dart';
import 'package:afariat/networking/api/sign_up_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewController extends GetxController {
  final tapHomeViewController = Get.find<LocController>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  SignUpApi _signUpApi = SignUpApi();

  post() {
    User user = User(
        email: email.text,
        city: tapHomeViewController.citie.id,
        name: name.text,
        phone: phone.text,
        plainPassword: password.text,
        type: 0);

    _signUpApi.post({}).then((value) {
      print(value);
    });
    /* if(name.text!=null&&password.text!=null&&phone.text!=null&&email.text!=null ){



    }*/
  }
}
