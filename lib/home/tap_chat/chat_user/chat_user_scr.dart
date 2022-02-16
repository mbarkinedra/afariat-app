import 'dart:convert';
import 'dart:math';

import 'package:afariat/mywidget/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'chat_user_viewcontroller.dart';
import 'package:bubble/bubble.dart';

class ChatUserScr extends GetWidget<ChatUserViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.deepOrange,
        title: Text(
          controller.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:


      GetBuilder<ChatUserViewController>(builder: (logic) {
        return Container(color: Colors.blue,
          child: Chat(
            onEndReached: logic.getMessage,
            bubbleBuilder: logic.bubbleBuilder,
            theme: const DefaultChatTheme(
                inputBackgroundColor: Colors.black12,
                inputTextColor: Colors.black,
                sendButtonIcon: Icon(
                  Icons.send,
                  color: Colors.deepOrange,
                )),
            messages: logic.messages,
            showUserAvatars: true,
            onSendPressed: logic.handleSendPressed,
            user: logic.user,
            onTextChanged: (v) {
              logic.message = v;
            },
          ),
        );
      }),
    );
  }
}