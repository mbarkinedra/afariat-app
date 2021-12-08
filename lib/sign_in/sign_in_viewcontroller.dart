import 'package:afariat/networking/api/sign_in_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignInViewController extends GetxController{
TextEditingController name=TextEditingController();
TextEditingController password=TextEditingController();
SignInApi _signInApi=SignInApi();
getwss(){
 _signInApi.post({"login": "${name.text}"}).then((value) {

 });
}
}