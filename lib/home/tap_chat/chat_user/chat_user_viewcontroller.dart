import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatUserViewController extends GetxController {
  TextEditingController controller = TextEditingController();
  String userName = "CapsaSystems";
  RxBool send = false.obs;

  setUserName({String username}) {
    userName = username;
  }

  onChanged(String v) {
    if (v.trim().isNotEmpty) {
      send.value = true;
    } else {
      send.value = false;
    }
  }
}
