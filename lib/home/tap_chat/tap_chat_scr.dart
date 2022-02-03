import 'package:afariat/mywidget/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'chat_user/chat_user_scr.dart';
import 'chat_user/chat_user_viewcontroller.dart';
import 'tap_chat_viewcontroller.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class TapChatScr extends GetWidget<TapChatViewController> {
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Messagerie",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 , color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,

        ),
        body: ListView.builder(
            itemCount: 100,
            itemBuilder: (contex, pos) {
              return GestureDetector(
                  onTap: () {
                    //
                    Get.find<ChatUserViewController>().messages.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatUserScr()));
                  },
                  child: ChatUser());
            }));
  }
}
