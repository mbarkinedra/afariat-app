import 'package:afariat/mywidget/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'chat_user/chat_user_scr.dart';
import 'tap_chat_viewcontroller.dart';

class TapChatScr extends GetWidget<TapChatViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    //
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Messagerie",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: ListView.builder(
            itemCount: 100,
            itemBuilder: (contex, pos) {
              return GestureDetector(
                  onTap: () {
                    //
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatUserScr()));
                  },
                  child: ChatUser());
            }));
  }
}
