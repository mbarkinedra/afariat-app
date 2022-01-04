import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TapProfileViewController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    //TODO: Call the get user info ws to get user phone and name
    // name.text = storge.readSecureData(storge.key_name);
    // phone.text = storge.readSecureData(storge.key_phone);
  }

  updatname(v) {
    //TODO: Call the webservice PUT user to update user info in server side
    //storge.writeSecureData(storge.key_name, v);
  }

  updatphone(v) {
    //TODO: Call the webservice PUT user to update user info in server side
    //storge.writeSecureData(storge.key_phone, v);
  }
}