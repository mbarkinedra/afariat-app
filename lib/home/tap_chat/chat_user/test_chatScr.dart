import 'dart:convert';
import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class TestChatcr extends StatefulWidget {

  @override
  _TestChatcrState createState() => _TestChatcrState();
}

class _TestChatcrState extends State<TestChatcr> {
  List<types.Message> _messages = [];
  int ii = 0;
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: ii % 2 == 0 ? '06c33e8b-e835-4736-80f4-63f44b66666c' : randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    ii++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Container(color: Colors.blue,),
          Chat(bubbleBuilder: bubbleBuilder,
            showUserAvatars: false,
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
          ),
        ],
      ),
    );
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

Widget bubbleBuilder(Widget child, {
  message,
  nextMessageInGroup,
}) {
  return Bubble(
    alignment: '06c33e8b-e835-4736-80f4-63f44b66666c' != message.id ? Alignment
        .topLeft : Alignment.topRight,
    style: BubbleStyle(),


    child: child,
    color: '06c33e8b-e835-4736-80f4-63f44b66666c' != message.id ||
        message.type == types.MessageType.image
        ? const Color(0xff42cd42)
        : const Color(0xff6f61e8),
    margin: nextMessageInGroup
        ? const BubbleEdges.symmetric(horizontal: 0)
        : null,
    nip: nextMessageInGroup
        ? BubbleNip.no
        : '06c33e8b-e835-4736-80f4-63f44b66666c' != message.id
        ? BubbleNip.leftBottom
        : BubbleNip.rightBottom,
  );
}