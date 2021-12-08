import 'dart:convert';

import 'package:afariat/config/wsse.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:afariat/networking/api/sign_in_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignInViewController extends GetxController{
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();
GetSalt _getSalt=GetSalt();
SignInApi _signInApi=SignInApi();
getwsse(){
 _getSalt.post({"login": "${email.text}"}).then((value) {
   //value.data["salt"];
    

  String hashedPassword= hashPassword(password.text,value.data["salt"]);
  print(hashedPassword);
  String wsse = generateWsseHeader(email.text,hashedPassword);
  print(wsse);

  _signInApi.get({'X-WSSE': wsse} ).then((value){
print(value.data);
  });
 });
}

}