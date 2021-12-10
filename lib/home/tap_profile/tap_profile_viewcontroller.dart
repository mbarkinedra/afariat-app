import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TapProfileViewController extends GetxController {
  String pic="";
  var box = GetStorage();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  RxBool arupdate = false.obs;

  @override
  void onInit() {
    super.onInit();
    name.text = box.read("name",);
    phone.text = box.read("phone");
    email.text = box.read("email");
    print(box.read("phone"));
  }




}