import 'package:afariat/mywidget/chat_user.dart';
import 'package:afariat/networking/api/get_message_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          key: UniqueKey(),
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
                                Get.find<ChatUserViewController>().getMessage();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatUserScr()));
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
