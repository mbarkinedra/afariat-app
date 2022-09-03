import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'chat_user_viewcontroller.dart';

class ChatUserScr extends GetWidget<ChatUserViewController> {
  const ChatUserScr({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: framColor,
        title: Text(
          controller.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<ChatUserViewController>(builder: (logic) {
        return Container(
          color: Colors.blue,
          child: Chat(
            onEndReached: logic.getMessage,
            bubbleBuilder: logic.bubbleBuilder,
            theme: const DefaultChatTheme(
                inputBackgroundColor: Colors.black12,
                inputTextColor: Colors.black,
                sendButtonIcon: Icon(
                  Icons.send,
                  color:buttonColor,
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
