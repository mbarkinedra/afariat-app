import 'package:afariat/mywidget/chat_user.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'chat_user/chat_user_scr.dart';
import 'chat_user/chat_user_viewcontroller.dart';
import 'tap_chat_viewcontroller.dart';
import 'dart:convert';
import 'dart:math';

class TapChatScr extends GetWidget<TapChatViewController> {
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Messagerie",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: GetBuilder<TapChatViewController>(builder: (logic) {
          return logic.getData
              ? Center(child: const CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => controller.pagingController.refresh(),
                  ),
                  child: PagedListView<int, dynamic>(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, item, index) {
                        print("controller ${controller.conversations.length}");
                        return controller.conversations.length == 0
                            ? Container(
                                child: Center(
                                child: Text("Pas des conversation."),
                              ))
                            : Dismissible(
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                key: Key(
                                    item.id.toString()), // key: UniqueKey(),
                                onDismissed: (direction) {
                                  controller.deleteConversation(item.id, item);
                                },
                                child: GestureDetector(
                                    onTap: () {
                                      Get.find<ChatUserViewController>().name =
                                          item.to.username;
                                      Get.find<ChatUserViewController>().id =
                                          item.id.toString();
                                      Get.find<ChatUserViewController>()
                                          .messages
                                          .clear();
                                      Get.find<ChatUserViewController>()
                                          .getMessage();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatUserScr()));
                                    },
                                    child: ChatUser(
                                      conversation: item,
                                      hasConversaton:
                                          item.totalUnreadMessagesCount > 0,
                                    )),
                              );
                      },
                    ),
                  ),
                );
        }));
  }
}
