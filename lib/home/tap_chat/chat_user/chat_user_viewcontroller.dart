import 'dart:convert';
import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class ChatUserViewController extends GetxController {
  TextEditingController controller = TextEditingController();
  String userName = "CapsaSystems";
  RxBool send = false.obs;
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  List<types.Message> messages = [];
  final user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  void addMessage(types.Message message) {
    messages.insert(0, message);
    update();
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    addMessage(textMessage);
  }

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



  Widget bubbleBuilder(
      Widget child, {
        message,
        nextMessageInGroup,
      }) {
    return Bubble(
      child: child,
      color: user.id != message.author.id ||
          message.type == types.MessageType.image
          ? const Color(0xfff5f5f7)
          : const Color(0xFFE65100),
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6)
          : null,
      nip: nextMessageInGroup
          ? BubbleNip.no
          : user.id != message.author.id
          ? BubbleNip.leftBottom
          : BubbleNip.rightBottom,
    );
  }
}
