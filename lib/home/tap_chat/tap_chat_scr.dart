import 'package:afariat/controllers/connexion_controller.dart';
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
  // String randomString() {
  //   final random = Random.secure();
  //   final values = List<int>.generate(16, (i) => random.nextInt(255));
  //   return base64UrlEncode(values);
  // }

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
        body: Obx(
          () => Column(
            children: [
              Get.find<NetWorkController>().connectionStatus.value == false
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                      height: 50,
                      width: 50,
                    )
                  : SizedBox(),
              Get.find<NetWorkController>().connectionStatus.value
                  ? Expanded(
                      child:
                          GetBuilder<TapChatViewController>(builder: (logic) {
                        return logic.getData
                            ? Center(child: const CircularProgressIndicator())
                            : RefreshIndicator(
                                onRefresh: () => Future.sync(
                                  () => controller.pagingController.refresh(),
                                ),
                                child: PagedListView<int, dynamic>(
                                  pagingController: controller.pagingController,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<dynamic>(
                                    itemBuilder: (context, item, index) {
                                      print(
                                          "controller ${controller.conversations.length}");
                                      return controller.conversations.length ==
                                              0
                                          ? Container(
                                              child: Center(
                                              child:
                                                  Text("Pas des conversation."),
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
                                              key: Key(item.id
                                                  .toString()), // key: UniqueKey(),
                                              onDismissed: (direction) {
                                                controller.deleteConversation(
                                                    item.id, item);
                                              },
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Get.find<ChatUserViewController>()
                                                            .name =
                                                        item.to.username;
                                                    Get.find<ChatUserViewController>()
                                                            .id =
                                                        item.id.toString();
                                                    Get.find<
                                                            ChatUserViewController>()
                                                        .messages
                                                        .clear();
                                                    Get.find<
                                                            ChatUserViewController>()
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
                                                        item.totalUnreadMessagesCount >
                                                            0,
                                                  )),
                                            );
                                    },
                                  ),
                                ),
                              );
                      }),
                    )
                  : Expanded(
                      child: Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off_rounded,
                            size: 80,
                            color: Colors.deepOrangeAccent,
                          ),
                          Text(
                            "Pas de connexion internet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          /*   Text("Connect_toi a internet et réessaie.",style: TextStyle(color: Colors.black45),)*/
                        ],
                      )),
                    )),
            ],
          ),
        ));
  }
}
