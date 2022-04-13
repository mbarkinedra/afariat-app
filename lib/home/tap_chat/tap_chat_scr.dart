import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/mywidget/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_user/chat_user_scr.dart';
import 'chat_user/chat_user_viewcontroller.dart';
import 'tap_chat_viewcontroller.dart';

class TapChatScr extends GetWidget<TapChatViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Messagerie",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          backgroundColor: framColor,
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
                                onRefresh: controller.onRefreshAds,
                                child: logic.conversations.isEmpty
                                    ? Center(
                                        child:
                                            Text("Aucune conversations trouvé",style: TextStyle(fontWeight: FontWeight.bold),),
                                      )
                                    : ListView.builder(
                                        controller: controller.scrollController,
                                        itemCount: logic.conversations.length,
                                        itemBuilder: (context, position) {
                                          print(logic.conversations.length);
                                          logic.conversations
                                              .forEach((element) {
                                            print(element.toJson());
                                          });
                                          return Dismissible(
                                            background: Container(
                                              color: Colors.red,
                                              child: Icon(
                                                Icons.delete,
                                                size: 35,
                                                color: Colors.white,
                                              ),
                                            ),
                                            key: Key(logic
                                                .conversations[position].id
                                                .toString()), // key: UniqueKey(),
                                            onDismissed: (direction) {
                                              controller.deleteConversation(
                                                  logic.conversations[position]
                                                      .id,
                                                  logic
                                                      .conversations[position]);
                                            },
                                            child: GestureDetector(
                                                onTap: () {
                                                  Get.find<
                                                          ChatUserViewController>()
                                                      .name = logic
                                                              .conversations[
                                                                  position]
                                                              .to
                                                              .username ==
                                                          Get.find<
                                                                  AccountInfoStorage>()
                                                              .readEmail()
                                                      ? logic
                                                          .conversations[
                                                              position]
                                                          .from
                                                          .username
                                                      : logic
                                                          .conversations[
                                                              position]
                                                          .to
                                                          .username;
                                                  Get.find<ChatUserViewController>()
                                                          .id =
                                                      logic
                                                          .conversations[
                                                              position]
                                                          .id
                                                          .toString();
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
                                                  conversation: logic
                                                      .conversations[position],
                                                  email: Get.find<
                                                          AccountInfoStorage>()
                                                      .readEmail(),
                                                  hasConversaton: logic
                                                          .conversations[
                                                              position]
                                                          .totalUnreadMessagesCount >
                                                      0,
                                                )),
                                          );
                                        }),
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
                            color: framColor,
                          ),
                          Text(
                            "Pas de connexion internet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      )),
                    )),
            ],
          ),
        ));
  }
}
