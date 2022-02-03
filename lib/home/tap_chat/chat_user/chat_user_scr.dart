import 'package:afariat/mywidget/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:get/get.dart';

import 'chat_user_viewcontroller.dart';

class ChatUserScr extends GetWidget<ChatUserViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, pos) {
                    if (pos % 2 == 0) {
                      return ChatBubble(
                        clipper:
                            ChatBubbleClipper2(type: BubbleType.sendBubble),
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 20),
                        backGroundColor: Colors.blue,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            " Capsa Systems",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return ChatBubble(
                        clipper:
                            ChatBubbleClipper2(type: BubbleType.receiverBubble),
                        backGroundColor: Color(0xffE7E7ED),
                        margin: EdgeInsets.only(top: 20),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            "  Capsa Systems",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  margin: EdgeInsets.all(4),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            onChanged: controller.onChanged,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Username',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {},
                          child: Obx(() => Icon(
                                Icons.send,
                                color: controller.send.value
                                    ? Colors.blue
                                    : Colors.grey,
                              )))
                    ],
                  )),
            )
          ],
        ));
  }
}
